return {
	"saghen/blink.cmp",
	version = "*",
	build = "cargo build --release",
	dependencies = {
		"rafamadriz/friendly-snippets",
	},
	event = "InsertEnter",
	opts = {
		appearance = {
			use_nvim_cmp_as_default = false,
			nerd_font_variant = "mono",
		},
		sources = {
			default = { "lsp", "path", "buffer" },
			providers = {
				lsp = {
					name = "LSP",
					module = "blink.cmp.sources.lsp",
					score_offset = 100,
				},
				path = {
					name = "Path",
					module = "blink.cmp.sources.path",
					score_offset = 25,
				},
				buffer = {
					name = "Buffer",
					module = "blink.cmp.sources.buffer",
					score_offset = 15,
					min_keyword_length = 3,
				},
			},
		},
		completion = {
			documentation = {
				auto_show = true,
			},
			ghost_text = {
				enabled = true,
			},
			list = { selection = { preselect = true, auto_insert = false } },
			menu = {
				draw = {
					treesitter = { "lsp" },
					columns = {
						{ "kind_icon", "label", "label_description", gap = 1 },
						{ "kind", "source_name", gap = 1 },
					},
				},
			},
		},
		signature = {
			enabled = true,
		},
		keymap = {
			preset = "default",
			["<Up>"] = { "select_prev", "fallback" },
			["<Down>"] = { "select_next", "fallback" },
			["<C-p>"] = { "select_prev", "fallback" },
			["<C-n>"] = { "select_next", "fallback" },

			["<S-k>"] = { "scroll_documentation_up", "fallback" },
			["<S-j>"] = { "scroll_documentation_down", "fallback" },

			["<C-space>"] = { "show", "show_documentation", "hide_documentation" },
			["<CR>"] = { "accept", "fallback" },
			["<C-e>"] = { "hide", "fallback" },
		},
	},
	opts_extend = {
		"sources.default",
	},
}
