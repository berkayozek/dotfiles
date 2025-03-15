return {
	"echasnovski/mini.nvim",
	version = false,
	config = function()
		require("mini.ai").setup()
		require("mini.comment").setup()
		require("mini.move").setup()
		require("mini.pairs").setup()
		require("mini.starter").setup()

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
