vim.cmd [[packadd! vimspector]] -- Load vimspector

-- vim.g.vimspector_base_dir = os.getenv("HOME") .. '/.config/nvim/lua/user/vimspector/'
vim.g.vimspector_install_gadgets = {
    "vscode-go", -- Go
}

vim.g.vimspector_install_gadgets = {
            "vscode-go", -- Go
}

-- Mappings
vim.keymap.set("n", "<Leader>vt", ":call vimspector#ToggleBreakpoint()<CR>")
vim.keymap.set("n", "<Leader>vc", ":call vimspector#Continue()<CR>")
vim.keymap.set("n", "<Leader>vi", ":call vimspector#StepInto()<CR>")
vim.keymap.set("n", "<Leader>vo", ":call vimspector#StepOver()<CR>")
vim.keymap.set("n", "<Leader>vS", ":call vimspector#Stop()<CR>")
vim.keymap.set("n", "<Leader>vx", ":call vimspector#Reset()<CR>")
