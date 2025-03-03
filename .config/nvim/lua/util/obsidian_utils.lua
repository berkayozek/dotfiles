local git_utils = require("util.git_utils")

local M = {}

function M.find_workspace_for_file(workspaces)
	local current_file_path = vim.fn.expand("%:p")
	for _, workspace in ipairs(workspaces) do
		local workspace_path = vim.fn.expand(workspace.path)
		if current_file_path:find(workspace_path .. "/", 1, true) == 1 and workspace.backup then
			return workspace_path
		end
	end
	return nil
end

function M.generate_workspace_regex(opts)
	local regex_parts = {}
	for _, workspace in ipairs(opts.workspaces) do
		local workspace_path = vim.fn.expand(workspace.path)
		if workspace.backup then
			table.insert(regex_parts, workspace_path .. "/*.md")
		end
	end
	return tostring(table.concat(regex_parts, ","))
end

function M.setup_custom_obsidian_commands(opts)
	vim.api.nvim_create_autocmd("BufReadPost", {
		pattern = M.generate_workspace_regex(opts),
		callback = function()
			local workspace = M.find_workspace_for_file(opts.workspaces)
			if workspace then
				git_utils.pull_git_async(workspace)
			end
		end,
	})

	vim.api.nvim_create_user_command("ObsidianPush", function()
		local workspace = M.find_workspace_for_file(opts.workspaces)
		if workspace then
			git_utils.push_git_backup_async(workspace)
		else
			vim.notify("⚠️  File not in Obsidian vault; push skipped.", "warn", { title = "Custom Obisidian.nvim" })
		end
	end, {})

	vim.api.nvim_create_user_command("ObsidianPull", function()
		local workspace = M.find_workspace_for_file(opts.workspaces)
		if workspace then
			git_utils.pull_git_async(workspace)
		else
			vim.notify("⚠️  File not in Obsidian vault; pull skipped.", "warn", { title = "Custom Obsidian.nvim" })
		end
	end, {})

	vim.api.nvim_create_user_command("ObsidianSwitchWorkspace", function()
		vim.ui.input({ prompt = "Enter workspace name: " }, function(workspace)
			if workspace and workspace ~= "" then
				local success, err = pcall(vim.cmd, "ObsidianWorkspace " .. workspace)
				if not success then
					vim.notify("❌ Workspace '" .. workspace .. "' not found!", "error", { title = "Custom Obsidian.nvim" })
				end
			else
				vim.notify("⚠️  Workspace name cannot be empty!", "warn", { title = "Custom Obsidian.nvim" })
			end
		end)
	end, {})
end

return M
