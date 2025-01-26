local map = vim.keymap
vim.g.mapleader = " "

-- Search word in the middle
vim.keymap.set("n", "n", "nzzzv")
vim.keymap.set("n", "N", "Nzzzv")

-- Copy the selected text or entire buffer to the system clipboard
map.set("n", "<leader>y", '"+y', { noremap = true, desc = "Copy to clipboard" })
map.set("v", "<leader>y", '"+y', { noremap = true, desc = "Copy to clipboard" }) -- For visual mode
map.set("n", "<leader>Y", '"+Y', { noremap = true, desc = "Copy to clipboard" }) -- For visual mode

-- Paste from the system clipboard
map.set("n", "<leader>p", '"+p', { noremap = true, desc = "Paste from clipboard" })
map.set("v", "<leader>p", '"+p', { noremap = true, desc = "Paste from clipboard" }) -- For visual mode