return {
	"akinsho/toggleterm.nvim",
	event = "VeryLazy",
	version = "*", -- Use the latest stable release
	config = function()
		require("toggleterm").setup({
			size = 15,
			close_on_exit = true,
			open_mapping = "<C-\\>",
		})
		vim.keymap.set("n", "<Leader>t", "<cmd>ToggleTerm<CR>", { desc = "toggle terminal" })

		function _G.set_terminal_keymaps()
			local opts = { buffer = 0 }
			vim.keymap.set("t", "<c-n>", [[<C-\><C-n>]], opts)
			vim.keymap.set("t", "<c-h>", [[<Cmd>wincmd h<CR>]], opts)
			vim.keymap.set("t", "<c-j>", [[<Cmd>wincmd j<CR>]], opts)
			vim.keymap.set("t", "<C-k>", [[<Cmd>wincmd k<CR>]], opts)
			vim.keymap.set("t", "<c-l>", [[<Cmd>wincmd l<CR>]], opts)
			vim.keymap.set("t", "<c-w>", [[<C-\><C-n><C-w>]], opts)
		end
		vim.cmd("autocmd! TermOpen term://* lua set_terminal_keymaps()")
	end,
}
