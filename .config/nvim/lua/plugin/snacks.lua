return {
	"folke/snacks.nvim",
	opts = {
		words = {},
		input = {},
		lazygit = {},
		indent = {
			filter = function(buf)
				local exclude = { "markdown", "text" }
				local ft = vim.bo[buf].filetype
				return not vim.tbl_contains(exclude, ft)
			end,
		},
		zen = {},
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
	},
}
