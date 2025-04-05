return {
	"folke/noice.nvim",
	event = "VeryLazy",
	opts = {
		notify = {
			enabled = false,
		},
		lsp = {
			progress = {
				enabled = false,
			},
		},
	},
	dependencies = {
		"MunifTanjim/nui.nvim",
		"folke/snacks.nvim",
	},
}
