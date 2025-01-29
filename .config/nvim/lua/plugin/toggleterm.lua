return {
	"akinsho/toggleterm.nvim",
	event = "VeryLazy",
	version = "*", -- Use the latest stable release
	config = function()
		require("toggleterm").setup({
			size = function(term)
				if term.direction == "horizontal" then
					return math.floor(vim.o.lines * 0.3) -- 30% of the screen height
				elseif term.direction == "vertical" then
					return math.floor(vim.o.columns * 0.3) -- 30% of the screen width
				else
					return 20 -- Default size for other directions (like window-based terminals)
				end
			end,
            direction = "float",
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
		end
		vim.cmd("autocmd! TermOpen term://* lua set_terminal_keymaps()")
	end,
}
