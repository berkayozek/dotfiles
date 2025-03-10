return {
	"aserowy/tmux.nvim",
	event = "VeryLazy",
	config = function()
		return require("tmux").setup({
			navigation = {
				enable_default_keybindings = true,
			},
		})
	end,
}
