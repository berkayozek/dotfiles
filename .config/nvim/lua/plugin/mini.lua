return {
	"echasnovski/mini.nvim",
	version = false,
	config = function()
		require("mini.ai").setup()
		require("mini.comment").setup()
		require("mini.move").setup()
		require("mini.pairs").setup()
		require("mini.starter").setup()
		require("mini.surround").setup({
			mappings = {
				add = "msa", -- Add surrounding in Normal and Visual modes
				delete = "msd", -- Delete surrounding
				find = "msf", -- Find surrounding (to the right)
				find_left = "msF", -- Find surrounding (to the left)
				highlight = "msh", -- Highlight surrounding
				replace = "msr", -- Replace surrounding
				update_n_lines = "msn", -- Update `n_lines`

				suffix_last = "ml", -- Suffix to search with "prev" method
				suffix_next = "mn", -- Suffix to search with "next" method
			},
		})
		require("mini.icons").setup({
			style = "glyph",
		})

		local snippets = require("mini.snippets")
		local gen_loader = snippets.gen_loader
		snippets.setup({
			snippets = {
				gen_loader.from_lang(),
			},
		})

		local hipatterns = require("mini.hipatterns")
		hipatterns.setup({
			highlighters = {
				fixme = { pattern = "()%s?FIXME:?()", group = "MiniHipatternsFixme" },
				hack = { pattern = "()%s?HACK:?()", group = "MiniHipatternsHack" },
				todo = { pattern = "()%s?TODO:?()", group = "MiniHipatternsTodo" },
				note = { pattern = "()%s?NOTE:?()", group = "MiniHipatternsNote" },

				hex_color = hipatterns.gen_highlighter.hex_color(),
			},
		})
	end,
}
