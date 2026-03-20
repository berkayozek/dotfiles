return {
	"nvim-treesitter/nvim-treesitter",
	lazy = false,
	build = ":TSUpdate",
	event = { "BufReadPre", "BufNewFile" },
	dependencies = { "OXY2DEV/markview.nvim" },
	config = function()
		vim.opt.runtimepath:append(vim.fn.stdpath("data") .. "/site/")
		require("nvim-treesitter").setup({
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
			auto_install = true,
		})
	end,
}
