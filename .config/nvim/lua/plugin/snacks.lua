return {
	"folke/snacks.nvim",
	lazy = true,
	opts = {
		words = {},
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
	},
}
