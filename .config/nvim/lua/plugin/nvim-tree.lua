return {
	"nvim-tree/nvim-tree.lua",
	version = "*",
	lazy = true,
	cmd = { "NvimTreeToggle", "NvimTreeFocus" }, -- Commands that trigger loading
	keys = {
		{ "<Tab>", "<cmd>NvimTreeToggle<CR>", desc = "Toggle NvimTree" }, -- Keymap to trigger loading
		{ "n", "<Leader>ntr", "<cmd>NvimTreeRefresh<CR>", desc = "Refresh NvimTree" }, -- Keymap to trigger loading
	},
	dependencies = {
		"nvim-tree/nvim-web-devicons",
	},
	opts = {
		actions = {
			open_file = {
				quit_on_open = true,
			},
		},
		sort_by = "case_sensitive",
		diagnostics = {
			enable = false,
			icons = {
				hint = "❔",
				info = "❕",
				warning = "❗",
				error = "❌",
			},
		},
		view = {
			adaptive_size = true,
		},
		renderer = {
			group_empty = true,
		},
		filters = {
			dotfiles = true,
		},
		filesystem_watchers = {
			enable = true,
			debounce_delay = 50,
			ignore_dirs = { "target" },
		},
	},
}
