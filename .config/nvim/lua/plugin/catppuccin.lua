
return {
    'catppuccin/nvim', 
    name = 'catppuccin',
    config = function()
        require("catppuccin").setup({
            flavour = "mocha", -- latte, frappe, macchiato, mocha
            background = { -- :h background
                light = "latte",
                dark = "mocha",
            },
            transparent_background = false,
            term_colors = false,
            no_italic = true, -- force no italic
            no_bold = false, -- force no bold
            integrations = {
                gitsigns = true,
                leap = true,
                nvimtree = true,
                telescope = true,
                treesitter = true,
                vimwiki = true,
                which_key = true
            },
            native_lsp = {
                enabled = false,
                underlines = {
                    errors = { "underline" },
                    hints = { "underline" },
                    warnings = { "underline" },
                    information = { "underline" },
            },

        },
        indent_blankline = {
        enabled = true,
    },
})

vim.cmd.colorscheme "catppuccin"
    end
}
