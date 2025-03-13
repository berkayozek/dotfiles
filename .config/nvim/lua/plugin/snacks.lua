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
	},
	keys = {
		{
			"<leader>gg",
			function()
				Snacks.lazygit()
			end,
			desc = "Lazygit",
		},
	},
}
