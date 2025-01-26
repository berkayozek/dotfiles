return {
		"nvim-tree/nvim-tree.lua",
		version = "*",
		lazy = false,
		dependencies = {
			"nvim-tree/nvim-web-devicons",
		},
		config = function()
            vim.g.loaded_netrw = 1
            vim.g.loaded_netrwPlugin = 1

            -- set termguicolors to enable highlight groups
            vim.opt.termguicolors = true

-- Key Mappings
vim.keymap.set("n", "<Tab>", ":NvimTreeToggle<CR>", {noremap = true, silent = true})
vim.keymap.set('n', 'vr', ':NvimTreeRefresh<CR>')

			require("nvim-tree").setup({
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
        }
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
        ignore_dirs = {"target"},
    },
})
		end,
}
