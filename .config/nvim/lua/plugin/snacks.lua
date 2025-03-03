return {
	"folke/snacks.nvim",
	opts = {
		words = {},
		input = {},
		lazygit = {},
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
