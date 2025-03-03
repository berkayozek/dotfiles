local M = {}

function M.is_git_repo_initialized(path)
	local git_dir = vim.fn.system("cd " .. path .. " && git rev-parse --is-inside-work-tree")
	return git_dir:match("true") ~= nil
end

local function run_git_command_async(path, args, success_msg, error_msg, callback)
	if not M.is_git_repo_initialized(path) then
		vim.notify(
			"⚠️  Git is not initialized in the directory: " .. tostring(path),
			"warn",
			{ title = "Git Utils" }
		)
		return
	end

	vim.loop.spawn("git", {
		args = { "-C", path, unpack(args) },
		stdio = { nil, vim.loop.new_pipe(false), vim.loop.new_pipe(false) },
	}, function(code, _, stderr)
		vim.schedule(function()
			if code == 0 then
				vim.notify(success_msg, "info", { title = "Git Utils" })
				if callback then
					callback()
				end
			else
				local error_output = stderr and stderr:read() or "Unknown error"
				vim.notify(error_msg .. "\n" .. error_output, "error", { title = "Git Utils" })
			end
		end)
	end)
end

function M.pull_git_async(path)
	run_git_command_async(
		path,
		{ "pull", "origin", "main" },
		"📥 Pulled latest changes from GitHub for " .. path,
		"⚠️ Git pull failed for " .. path
	)
end

function M.push_git_backup_async(path)
	run_git_command_async(path, { "add", "." }, "📤 Staged files for commit", "⚠️  Git add failed", function()
		run_git_command_async(
			path,
			{ "commit", "-m", "Manual backup: " .. os.date("%Y-%m-%d %H:%M:%S") },
			"✅ Committed changes",
			"⚠️  Git commit failed",
			function()
				run_git_command_async(
					path,
					{ "push", "origin", "main" },
					"📤 Pushed backup successfully",
					"⚠️  Git push failed"
				)
			end
		)
	end)
end

return M
