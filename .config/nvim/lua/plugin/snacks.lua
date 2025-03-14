return {
	"folke/snacks.nvim",
	lazy = true,
	opts = {
		words = {
			modes = { "n" },
		},
		input = {},
		lazygit = {},
		indent = {
			filter = function(buf)
				local exclude = { "markdown", "text", "leetcode.nvim" }
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
			"<C-n>",
			function()
				if vim.fn.mode() == "t" then
					vim.cmd("stopinsert")
				end
			end,
			desc = "Exit terminal mode",
			mode = { "t" }, -- only apply in terminal mode
		},
	},
}
