return {
	"catppuccin/nvim",
	name = "catppuccin",
	priority = 1000,
	config = function()
		require("catppuccin").setup({
			flavour = "mocha", -- latte, frappe, macchiato, mocha
			background = {
				light = "latte",
				dark = "mocha",
			},
			transparent_background = false,
			term_colors = false,
			no_italic = false,
			no_bold = false,
			styles = {
				conditionals = {},
			},
			integrations = {
				blink_cmp = true,
				gitsigns = true,
				notify = true,
				mini = {
					enabled = true,
					indentscope_color = "",
				},
				flash = true,
				telescope = false,
				treesitter = true,
				which_key = true,
				snacks = {
					enabled = true,
					indent_scope_color = "",
				},
				neotest = true,
			},
		})

		vim.cmd.colorscheme("catppuccin")
	end,
}
