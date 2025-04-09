return {
	{
		"kawre/leetcode.nvim",
		cmd = "Leet",
		event = { "BufRead leetcode.nvim", "BufNewFile leetcode.nvim" },
		build = ":TSUpdate html",
		dependencies = {
			"nvim-telescope/telescope.nvim",
			"nvim-lua/plenary.nvim",
			"MunifTanjim/nui.nvim",
		},
		opts = {
			lang = "java",
			injector = {
				["java"] = {
					before = "import java.util.*;",
				},
			},
		},
		keys = {
			{ "<leader>ll", "<cmd>Leet list<cr>", desc = "Leet list questions" },
			{ "<leader>lr", "<cmd>Leet run<cr>", desc = "Leet run question" },
			{ "<leader>lt", "<cmd>Leet tabs<cr>", desc = "Leet tabs" },
			{ "<leader>lc", "<cmd>Leet console<cr>", desc = "Leet toggle console" },
			{ "<leader>ls", "<cmd>Leet submit<cr>", desc = "Leet submit question" },
			{ "<leader>lo", "<cmd>Leet open<cr>", desc = "Leet open question on browser" },
		},
	},
	{ "ThePrimeagen/vim-be-good", cmd = "VimBeGood" },
}
