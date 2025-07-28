return {
	{

		"jay-babu/mason-nvim-dap.nvim",
		lazy = true,
		event = "BufReadPre",
		opts = {
			ensure_installed = { "delve", "javadbg", "javatest" },
		},
	},
	{
		"mfussenegger/nvim-dap",
		lazy = true,
		event = "BufReadPre",
		dependencies = {
			"rcarriga/nvim-dap-ui",
			"nvim-neotest/nvim-nio",
		},
		config = function()
			local dap = require("dap")
			local dapui = require("dapui")

			-- DAP UI setup
			dapui.setup()

			-- Automatically open dap-ui when debugging starts
			dap.listeners.after.event_initialized["dapui_config"] = function()
				dapui.open()
			end

			-- Close dap-ui when debugging ends
			dap.listeners.before.event_terminated["dapui_config"] = function()
				dapui.close()
			end
			dap.listeners.before.event_exited["dapui_config"] = function()
				dapui.close()
			end

			-- Keymaps
			vim.keymap.set("n", "<F5>", dap.continue, { desc = "Debug: Start/Continue" })
			vim.keymap.set("n", "<F9>", dap.toggle_breakpoint, { desc = "Debug: Toggle Breakpoint" })
			vim.keymap.set("n", "<F10>", dap.step_over, { desc = "Debug: Step Over" })
			vim.keymap.set("n", "<F6>", dap.step_into, { desc = "Debug: Step Into" })
			vim.keymap.set("n", "<F7>", dap.step_out, { desc = "Debug: Step Out" })

			-- More detailed keymaps
			vim.keymap.set("n", "<leader>db", dap.toggle_breakpoint, { desc = "Debug: Toggle Breakpoint" })
			vim.keymap.set("n", "<leader>dB", function()
				dap.set_breakpoint(vim.fn.input("Breakpoint condition: "))
			end, { desc = "Debug: Set Conditional Breakpoint" })

			-- DAP UI keymaps
			vim.keymap.set("n", "<leader>du", dapui.toggle, { desc = "Debug: Toggle UI" })
			vim.keymap.set("n", "<leader>de", dapui.eval, { desc = "Debug: Evaluate Expression" })
			vim.keymap.set("n", "<leader>dh", require("dap.ui.widgets").hover, { desc = "Debug: Hover" })

			-- Terminal keymaps
			vim.keymap.set("n", "<leader>dr", dap.repl.open, { desc = "Debug: Open REPL" })

			-- Utility keymaps
			vim.keymap.set("n", "<leader>dl", function()
				require("dap").run_last()
			end, { desc = "Debug: Run Last" })

			-- Cleanup keymaps
			vim.keymap.set("n", "<leader>dc", dap.terminate, { desc = "Debug: Terminate" })
		end,
	},
	{
		"rcarriga/nvim-dap-ui",
		lazy = true,
		event = "BufReadPre",
		dependencies = { "mfussenegger/nvim-dap", "nvim-neotest/nvim-nio" },
	},
}
