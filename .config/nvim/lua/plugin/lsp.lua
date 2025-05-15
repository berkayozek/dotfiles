return {
	{
		"mfussenegger/nvim-jdtls",
		ft = "java",
	},
	{
		"williamboman/mason.nvim",
		cmd = "Mason",
		keys = { { "<leader>cm", "<cmd>Mason<cr>", desc = "Mason" } },
		build = ":MasonUpdate",
		opts = {
			ensure_installed = {
				"jdtls",
				"typescript-language-server",
				"pyright",
				"gopls",
				"clangd",
				"lemminx",
				"smithy-language-server",
				"lua-language-server",
				"ltex-ls",
			},
		},
	},
	{
		"mason-org/mason-lspconfig.nvim",
		event = { "BufReadPre", "BufNewFile" },
		dependencies = {
			"mason-org/mason.nvim",
		},
		opts = {
			automatic_enable = {
				exclude = { "jdtls" },
			},
		},
	},
	{
		"neovim/nvim-lspconfig",
		event = { "BufReadPost", "BufWritePost", "BufNewFile" },
		config = function()
			vim.api.nvim_create_autocmd("LspAttach", {
				desc = "LSP actions",
				callback = function(event)
					local function buf_set_keymap(mode, lhs, rhs, desc)
						vim.keymap.set(
							mode,
							lhs,
							rhs,
							{ buffer = event.buf, desc = desc, noremap = true, silent = true }
						)
					end

					buf_set_keymap("n", "K", vim.lsp.buf.hover, "Show hover information")
					buf_set_keymap("n", "gd", vim.lsp.buf.definition, "Go to definition")
					buf_set_keymap("n", "gD", vim.lsp.buf.declaration, "Go to declaration")
					buf_set_keymap("n", "gi", vim.lsp.buf.implementation, "Go to implementation")
					buf_set_keymap("n", "go", vim.lsp.buf.type_definition, "Go to type definition")
					buf_set_keymap("n", "gr", vim.lsp.buf.references, "Show references")
					buf_set_keymap("n", "gs", vim.lsp.buf.signature_help, "Show signature help")
					buf_set_keymap("n", "<Leader>rn", vim.lsp.buf.rename, "Rename symbol")
					buf_set_keymap({ "n", "x" }, "<Leader>ca", vim.lsp.buf.code_action, "Show code actions")
					buf_set_keymap("n", "<leader>e", vim.diagnostic.open_float, "Open diagnostic float")
					buf_set_keymap("n", "[d", vim.diagnostic.goto_prev, "Go to previous diagnostic")
					buf_set_keymap("n", "]d", vim.diagnostic.goto_next, "Go to next diagnostic")
					buf_set_keymap("n", "<leader>q", vim.diagnostic.setloclist, "Set location list")
					buf_set_keymap("n", "<leader>td", function()
						vim.diagnostic.enable(not vim.diagnostic.is_enabled())
					end, "Toggle diagnostic")
				end,
			})
		end,
	},
	{
		"jay-babu/mason-null-ls.nvim",
		event = { "BufReadPre", "BufNewFile" },
		dependencies = {
			"williamboman/mason.nvim",
			"nvimtools/none-ls.nvim",
		},
		opts = {
			ensure_installed = {
				"stylua",
				"goimports",
				"google-java-format",
				"ts-standard",
				"fixjson",
			},
		},
	},
	{
		"stevearc/conform.nvim",
		event = { "BufWritePre" },
		cmd = { "ConformInfo" },
		keys = {
			{
				-- Customize or remove this keymap to your liking
				"<leader>f",
				function()
					require("conform").format({ async = true })
				end,
				mode = "",
				desc = "Format buffer",
			},
		},
		opts = {
			formatters_by_ft = {
				lua = { "stylua" },
				go = { "goimports" },
				java = { "google-java-format" },
				typescript = { "prettier" },
				json = { "fixjson" },
			},
			default_format_opts = {
				lsp_format = "fallback",
			},
			format_on_save = false,
			formatters = {
				shfmt = {
					prepend_args = { "-i", "2" },
				},
				["google-java-format"] = {
					prepend_args = { "--aosp" }, -- Ensure 4-space indentation
				},
			},
		},
		init = function()
			vim.o.formatexpr = "v:lua.require'conform'.formatexpr()"
		end,
	},
}
