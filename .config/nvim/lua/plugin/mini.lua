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

		local map_multistep = require("mini.keymap").map_multistep
		map_multistep("i", "<Tab>", { "pmenu_next" })
		map_multistep("i", "<S-Tab>", { "pmenu_prev" })
		map_multistep("i", "<CR>", { "pmenu_accept", "minipairs_cr" })
		map_multistep("i", "<BS>", { "minipairs_bs" })

		local map_combo = require("mini.keymap").map_combo
		local mode = { "i", "c", "x", "s" }
		map_combo(mode, "jk", "<BS><BS><Esc>")
		map_combo(mode, "kj", "<BS><BS><Esc>")
	end,
}
