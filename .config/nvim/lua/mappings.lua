local map = vim.keymap
local noremap = { noremap = true }
local fn = vim.fn
local api = vim.api

-- Exit insert mode
map.set("i", "<C-c>", "<Esc>")

-- Vimwiki
-- vim.cmd("let g:vimwiki_list = [{'path' : 'C:\Users\berka\Documents\vimwiki', 'syntax' : 'markdown', 'ext' : '.md'}]")
-- map.set("n", "<C-z>", "<Plug>VimwikiToggleListItem")

-- Vimspector
map.set("n", "<Leader>vl", ":call vimspector#Launch()<CR>")
map.set("x", "<Leader>vr", ":VimspectorReset<CR>")
map.set("x", "<Leader>ve", ":VimspectorEval")
map.set("x", "<Leader>ve", ":VimspectorEval")
map.set("x", "<Leader>vw", ":VimspectorWatch")
map.set("x", "<Leader>vo", ":VimspectorShowOutput")

-- Insert mode keybindings
map.set("i", "<C-s>", "<C-o>I", noremap) -- To start of the line
map.set("i", "<C-a>", "<C-o>A", noremap) -- To end of the line
map.set("i", "<C-e>", "<ESC>ea", noremap) -- Move forward word
map.set("i", "<C-b>", "<C-o>b", noremap) -- Move backward word
map.set("n", '<Leader>dd', "<Cmd>BufferLineGoToBuffer 1<CR> <Cmd>BufferLineCloseRight<Cr>", { silent = true })

-- Normal mode keybindings

-- Half page jumping
map.set("n", "<C-d>", "<C-d>zz")
map.set("n", "<C-u>", "<C-u>zz")

-- Search word in the middle
map.set("n", "n", "nzzzv")
map.set("n", "N", "Nzzzv")

-- yank paragraph
map.set("n", "<Leader>y", "\"+y")
map.set("v", "<Leader>y", "\"+y")
map.set("n", "<Leader>Y", "\"+Y")

