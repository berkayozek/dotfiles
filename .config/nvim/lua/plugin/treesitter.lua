return {
	"nvim-treesitter/nvim-treesitter",
	build = ":TSUpdate",
	event = { "BufReadPre", "BufNewFile" },
	config = function()
		require("nvim-treesitter.configs").setup({
			-- A list of parser names, or "all"
			ensure_installed = {
				"c",
				"lua",
				"go",
				"java",
				"python",
				"json",
				"xml",
				"markdown",
				"markdown_inline",
				"latex",
				"yaml",
			},
			sync_install = false,
			auto_install = true,
			ignore_install = {},
			highlight = {
				enable = true,
				disable = {},
				additional_vim_regex_highlighting = false,
			},
			indent = {
				enable = true,
			},
		})
	end,
}
