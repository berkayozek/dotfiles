local mocha = require("catppuccin.palettes").get_palette "mocha"

require("bufferline").setup{ 
    highlights = require("catppuccin.groups.integrations.bufferline").get {
        styles = { "italic", "bold" },
        custom = {
            all = {
                fill = { bg = "#000000" },
            },
            mocha = {
                background = { fg = mocha.text },
            },
            latte = {
                background = { fg = "#000000" },
            },
        },
    },
    options = {
        diagnostics = "coc",
        diagnostics_update_in_insert = true,
        diagnostics_indicator = function(count, level, diagnostics_dict, context)
            return "("..count..")" 
        end,
        max_name_length = 18,
        show_buffer_close_icons = false,
        show_close_icon = false
    }
}

vim.keymap.set("n", "<Leader>1", "<Cmd>BufferLineGoToBuffer 1<CR>")
vim.keymap.set("n", "<Leader>2", "<Cmd>BufferLineGoToBuffer 2<CR>")
vim.keymap.set("n", "<Leader>3", "<Cmd>BufferLineGoToBuffer 3<CR>")
vim.keymap.set("n", "<Leader>4", "<Cmd>BufferLineGoToBuffer 4<CR>")
vim.keymap.set("n", "<Leader>5", "<Cmd>BufferLineGoToBuffer 5<CR>")
vim.keymap.set("n", "<Leader>6", "<Cmd>BufferLineGoToBuffer 6<CR>")
vim.keymap.set("n", "<Leader>7", "<Cmd>BufferLineGoToBuffer 7<CR>")
vim.keymap.set("n", "<Leader>8", "<Cmd>BufferLineGoToBuffer 8<CR>")
vim.keymap.set("n", "<Leader>9", "<Cmd>BufferLineGoToBuffer 9<CR>")
vim.keymap.set("n", "<Leader>$", "<Cmd>BufferLineGoToBuffer -1<CR>")

vim.keymap.set("n", "<Leader>l", "<Cmd>BufferLineCycleNext<CR>", {noremap = true, silent = true})
vim.keymap.set("n", "<Leader>h", "<Cmd>BufferLineCyclePrev<CR>", {noremap = true, silent = true})
