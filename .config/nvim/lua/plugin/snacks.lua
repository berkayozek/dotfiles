return {
	"folke/snacks.nvim",
	lazy = true,
	event = "BufReadPost",
	opts = {
		words = {
			modes = { "n" },
		},
		input = {},
		lazygit = {},
		indent = {
			filter = function(buf)
				local exclude = { "markdown", "text", "leetcode.nvim", "lazy", "mason" }
				local ft = vim.bo[buf].filetype
				return not vim.tbl_contains(exclude, ft)
			end,
		},
		zen = {},
		picker = {
			sources = {
				explorer = {
					auto_close = true,
				},
			},
		},
		terminal = {
			win = {
				position = "float",
				height = 0.8,
				width = 0.8,
				border = "rounded",
			},
			shell = vim.g.shell,
		},
		notifier = {},
	},
	keys = {
		{
			"<leader>gg",
			function()
				Snacks.lazygit()
			end,
			desc = "Toggle Lazygit",
		},
		{
			"<leader>gG",
			function()
				require("snacks.lazygit")({
					args = {
						"--git-dir=" .. os.getenv("HOME") .. "/.dotfiles",
						"--work-tree=" .. os.getenv("HOME"),
					},
					cwd = os.getenv("HOME"),
				})
			end,
			desc = "Lazygit (dotfiles)",
		},
		{
			"<leader>zz",
			function()
				Snacks.zen()
			end,
			desc = "Toggle zen mode",
		},
		{
			"<Tab>",
			function()
				Snacks.explorer()
			end,
			desc = "Toggle file explorer",
		},
		{
			"<C-q>",
			function()
				Snacks.terminal.toggle()
			end,
			desc = "Toggle Terminal",
			mode = { "n", "t" },
		},
		{
			"<C-\\>",
			function()
				if vim.fn.mode() == "t" then
					vim.cmd("stopinsert")
				end
			end,
			desc = "Exit terminal mode",
			mode = { "t" },
		},
		{
			"<leader>:",
			function()
				Snacks.picker.command_history()
			end,
			desc = "Command History",
		},
		{
			"<leader>n",
			function()
				Snacks.picker.notifications()
			end,
			desc = "Notification History",
		},
		{
			"<leader>fb",
			function()
				Snacks.picker.buffers({
					on_show = function()
						vim.cmd.stopinsert()
					end,
					current = true,
					sort_lastused = true,
					win = {
						input = {
							keys = {
								["d"] = "bufdelete",
							},
						},
						list = { keys = { ["d"] = "bufdelete" } },
					},
				})
			end,
			desc = "Buffers",
		},
		{
			"<leader>fc",
			function()
				Snacks.picker.files({ cwd = vim.fn.stdpath("config") })
			end,
			desc = "Find Config File",
		},
		{
			"<leader>ff",
			function()
				Snacks.picker.files()
			end,
			desc = "Find Files",
		},
		{
			"<leader>fg",
			function()
				Snacks.picker.git_files()
			end,
			desc = "Find Git Files",
		},
		{
			"<leader>fp",
			function()
				Snacks.picker.projects()
			end,
			desc = "Projects",
		},
		{
			"<leader>fr",
			function()
				Snacks.picker.recent()
			end,
			desc = "Recent",
		},
		{
			"<leader>gb",
			function()
				Snacks.picker.git_branches()
			end,
			desc = "Git Branches",
		},
		{
			"<leader>gl",
			function()
				Snacks.picker.git_log()
			end,
			desc = "Git Log",
		},
		{
			"<leader>gL",
			function()
				Snacks.picker.git_log_line()
			end,
			desc = "Git Log Line",
		},
		{
			"<leader>gs",
			function()
				Snacks.picker.git_status()
			end,
			desc = "Git Status",
		},
		{
			"<leader>gS",
			function()
				Snacks.picker.git_stash()
			end,
			desc = "Git Stash",
		},
		{
			"<leader>gd",
			function()
				Snacks.picker.git_diff()
			end,
			desc = "Git Diff (Hunks)",
		},
		{
			"<leader>gf",
			function()
				Snacks.picker.git_log_file()
			end,
			desc = "Git Log File",
		},
		{
			"<leader>sb",
			function()
				Snacks.picker.lines()
			end,
			desc = "Buffer Lines",
		},
		{
			"<leader>sB",
			function()
				Snacks.picker.grep_buffers()
			end,
			desc = "Grep Open Buffers",
		},
		{
			"<leader>sg",
			function()
				Snacks.picker.grep()
			end,
			desc = "Grep",
		},
		{
			"<leader>sw",
			function()
				Snacks.picker.grep_word()
			end,
			desc = "Visual selection or word",
			mode = { "n", "x" },
		},
		{
			"<leader>st",
			function()
				Snacks.picker.grep({
					search = "TODO:",
					on_show = function()
						vim.cmd.stopinsert()
					end,
				})
			end,
			desc = "Search TODO",
		},
		{
			"<leader>sT",
			function()
				Snacks.picker.grep({
					search = "(TODO|FIX|NOTE|FIXME)",
					regex = true,
					on_show = function()
						vim.cmd.stopinsert()
					end,
				})
			end,
			desc = "Search TODO, FIX, NOTE, and FIXME",
		},
	},
}
