return {
	"lewis6991/gitsigns.nvim",
	dependencies = {
		"nvim-lua/plenary.nvim",
	},
	opts = {
		on_attach = function(bufnr)
			local gitsigns = require("gitsigns")
			vim.keymap.set("n", "[g", gitsigns.prev_hunk, { buffer = bufnr, desc = "Jump to previous hunk" })
			vim.keymap.set("n", "]g", gitsigns.next_hunk, { buffer = bufnr, desc = "Jump to next hunk" })
			vim.keymap.set("n", "<leader>gs", gitsigns.stage_hunk, { buffer = bufnr, desc = "Stage hunk" })
			vim.keymap.set("n", "<leader>gu", gitsigns.undo_stage_hunk, { buffer = bufnr, desc = "Undo stage hunk" })
			vim.keymap.set("n", "<leader>gr", gitsigns.reset_hunk, { buffer = bufnr, desc = "Reset hunk" })
			vim.keymap.set("n", "<leader>gR", gitsigns.reset_buffer, { buffer = bufnr, desc = "Reset buffer" })
			vim.keymap.set("n", "<leader>gp", gitsigns.preview_hunk, { buffer = bufnr, desc = "Preview hunk" })
			vim.keymap.set("n", "<leader>gb", gitsigns.blame_line, { buffer = bufnr, desc = "Show blame information" })
			vim.keymap.set("n", "<leader>gS", gitsigns.stage_buffer, { buffer = bufnr, desc = "Stage entire buffer" })
			vim.keymap.set("n", "<leader>gD", gitsigns.diffthis, { buffer = bufnr, desc = "Diff buffer" })
			vim.keymap.set(
				"n",
				"<leader>gT",
				gitsigns.toggle_current_line_blame,
				{ buffer = bufnr, desc = "Toggle current blame" }
			)
			vim.keymap.set("n", "<leader>gd", gitsigns.toggle_deleted, { buffer = bufnr, desc = "Toggle deleted" })
		end,
	},
}
