return {
	"nvim-telescope/telescope.nvim",
	dependencies = {
		"nvim-lua/plenary.nvim",
	},
    opts = {
        defaults = {
            respect_cwd = false
        }
    },
	keys = {
		{ "<leader>fg", "<cmd>Telescope live_grep<cr>", desc = "Live grep" },
		{ "<leader>ff", "<cmd>Telescope find_files<cr>", desc = "Find file" },
	},
}
