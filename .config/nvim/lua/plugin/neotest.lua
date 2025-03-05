return {
	{
		"rcasia/neotest-java",
		ft = "java",
		dependencies = {
			"mfussenegger/nvim-jdtls",
			"mfussenegger/nvim-dap",
			"rcarriga/nvim-dap-ui",
		},
	},
	{
		"nvim-neotest/neotest",
		ft = "java",
		dependencies = {
			"nvim-neotest/nvim-nio",
			"nvim-lua/plenary.nvim",
			"antoinemadec/FixCursorHold.nvim",
			"nvim-treesitter/nvim-treesitter",
			"rcasia/neotest-java",
		},
		config = function()
			require("neotest").setup({
				adapters = {
					require("neotest-java"),
				},
			})

			vim.keymap.set("n", "<leader>np", function()
				require("neotest").run.run(vim.uv.cwd())
			end, { desc = "Test Project", noremap = true })

			vim.keymap.set("n", "<leader>nf", function()
				require("neotest").run.run(vim.fn.expand("%"))
			end, { desc = "Test File", noremap = true })

			vim.keymap.set("n", "<Leader>nd", function()
				require("neotest").run.run({ strategy = "dap" })
			end, { desc = "Debug Test File", noremap = true })

			vim.keymap.set("n", "<leader>nr", function()
				require("neotest").run.run()
			end, { desc = "Test Run", noremap = true })

			vim.keymap.set("n", "<leader>ns", function()
				require("neotest").summary.toggle()
			end, { desc = "Test Stop", noremap = true })

			vim.keymap.set("n", "<leader>na", function()
				require("neotest").run.attach()
			end, { desc = "Test Attach", noremap = true })

			vim.keymap.set("n", "<leader>no", function()
				require("neotest").output.open()
			end, { desc = "Test Open Output", noremap = true })
		end,
	},
}
