return {
	"nvim-treesitter/nvim-treesitter",
	lazy = false,
	build = ":TSUpdate",
	event = { "BufReadPre", "BufNewFile" },
	dependencies = { "OXY2DEV/markview.nvim" },
	config = function()
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

		vim.api.nvim_create_autocmd("FileType", {
			callback = function(args)
				pcall(vim.treesitter.start, args.buf)
			end,
		})
	end,
}
