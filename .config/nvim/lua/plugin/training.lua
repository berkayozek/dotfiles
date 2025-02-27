return {
	{
		"kawre/leetcode.nvim",
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
	},
	{ "ThePrimeagen/vim-be-good", lazy = true },
}
