local M = {}

M.get_visible_buffers = function()
	local visible_buffers = {}
	for _, buf in ipairs(vim.api.nvim_list_bufs()) do
		if vim.api.nvim_buf_is_loaded(buf) and vim.api.nvim_buf_get_option(buf, "buflisted") then
			table.insert(visible_buffers, buf)
		end
	end
	return visible_buffers
end

local function get_current_buffer_idx()
	local current_buf = vim.api.nvim_get_current_buf()
	for i, buf in ipairs(M.get_visible_buffers()) do
		if buf == current_buf then
			return i
		end
	end
	return 1
end

local setup_pick_buffer_shortcuts = function()
	for i = 1, 9 do
		vim.keymap.set("n", "<Leader>" .. i, function()
			local visible_buffers = M.get_visible_buffers()
			if visible_buffers[i] then
				vim.cmd("buffer " .. visible_buffers[i])
			end
		end, { silent = true, desc = "Switch to buffer " .. i })
	end
end

local setup_buffer_navigation_shortcuts = function()
	vim.keymap.set("n", "<Leader>h", function()
		local visible_buffers = M.get_visible_buffers()
		if #visible_buffers > 0 then
			local current_buffer_idx = get_current_buffer_idx()
			current_buffer_idx = (current_buffer_idx - 2) % #visible_buffers + 1
			vim.api.nvim_set_current_buf(visible_buffers[current_buffer_idx])
		end
	end, { silent = true, desc = "Switch to previous buffer" })

	vim.keymap.set("n", "<Leader>l", function()
		local visible_buffers = M.get_visible_buffers()
		if #visible_buffers > 0 then
			local current_buffer_idx = get_current_buffer_idx()
			current_buffer_idx = current_buffer_idx % #visible_buffers + 1
			vim.api.nvim_set_current_buf(visible_buffers[current_buffer_idx])
		end
	end, { silent = true, desc = "Switch to next buffer" })
end

M.setup_shortcuts = function()
	setup_pick_buffer_shortcuts()
	setup_buffer_navigation_shortcuts()
end

return M
