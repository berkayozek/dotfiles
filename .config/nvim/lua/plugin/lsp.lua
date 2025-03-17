local ensure_installed = {
	"jdtls",
	"typescript-language-server",
	"pyright",
	"gopls",
	"clangd",
	"lemminx",
	"smithy-language-server",
	"lua-language-server",
	"ltex-ls",
}
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
			ensure_installed = ensure_installed,
		},
		config = function(_, opts)
			require("mason").setup(opts)
			local mr = require("mason-registry")
			mr:on("package:install:success", function()
				vim.defer_fn(function()
					require("lazy.core.handler.event").trigger({
						event = "FileType",
						buf = vim.api.nvim_get_current_buf(),
					})
				end, 100)
			end)

			mr.refresh(function()
				for _, tool in ipairs(opts.ensure_installed) do
					local p = mr.get_package(tool)
					if not p:is_installed() then
						p:install()
					end
				end
			end)
		end,
	},
	{
		"neovim/nvim-lspconfig",
		event = { "BufReadPost", "BufWritePost", "BufNewFile" },
		dependencies = {
			"saghen/blink.cmp",
			"mason.nvim",
			{ "williamboman/mason-lspconfig.nvim", config = function() end },
		},
		opts = {
			servers = {
				jdtls = { enabled = false },
				lua_ls = {
					Lua = {
						diagnostics = {
							globals = { "bit", "vim", "it", "describe", "before_each", "after_each" },
						},
					},
				},
			},
		},
		config = function(_, opts)
			local lspconfig = require("lspconfig")
			local mason_lspconfig = require("mason-lspconfig")

			local capabilities = vim.tbl_deep_extend(
				"force",
				{},
				vim.lsp.protocol.make_client_capabilities(),
				require("blink.cmp").get_lsp_capabilities() or {},
				opts.capabilities or {}
			)
			local on_attach = function(_, bufnr)
				local function buf_set_keymap(mode, lhs, rhs, desc)
					vim.keymap.set(mode, lhs, rhs, { buffer = bufnr, desc = desc, noremap = true, silent = true })
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
			end

			mason_lspconfig.setup({
				handlers = {
					function(server_name)
						local settings = opts.servers[server_name] or {}

						if settings.enabled == false then
							return
						end

						lspconfig[server_name].setup({
							capabilities = capabilities,
							on_attach = on_attach,
							settings = settings,
						})
					end,
				},
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
