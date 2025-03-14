return {
	{
		"mfussenegger/nvim-jdtls",
		ft = "java",
	},
	{
		"neovim/nvim-lspconfig",
		dependencies = {
			-- LSP Support
			"williamboman/mason.nvim",
			"williamboman/mason-lspconfig.nvim",

			-- Autocompletion
			"hrsh7th/nvim-cmp",
			"hrsh7th/cmp-nvim-lsp",
			"hrsh7th/cmp-buffer",
			"hrsh7th/cmp-path",

			-- Snippets
			"echasnovski/mini.nvim",
			"rafamadriz/friendly-snippets",

			-- Formatter
			"stevearc/conform.nvim",
		},
		init = function()
			local mason = require("mason")
			local mason_lspconfig = require("mason-lspconfig")
			local cmp_lsp = require("cmp_nvim_lsp")
			local noop = function() end
			local capabilities = vim.tbl_deep_extend(
				"force",
				{},
				vim.lsp.protocol.make_client_capabilities(),
				cmp_lsp.default_capabilities()
			)

			vim.fn.sign_define("DiagnosticSignError", { text = "", texthl = "DiagnosticSignError", numhl = "" })
			vim.fn.sign_define("DiagnosticSignHint", { text = "", texthl = "DiagnosticSignHint", numhl = "" })
			vim.fn.sign_define("DiagnosticSignInfo", { text = "", texthl = "DiagnosticSignInfo", numhl = "" })
			vim.fn.sign_define("DiagnosticSignWarn", { text = "", texthl = "DiagnosticSignWarn", numhl = "" })

			mason.setup({})
			mason_lspconfig.setup({
				ensure_installed = {
					"jdtls",
					"ts_ls",
					"pyright",
					"gopls",
					"clangd",
					"lemminx",
					"smithy_ls",
					"lua_ls",
					"ltex",
				},
				handlers = {
					function(server_name)
						require("lspconfig")[server_name].setup({
							capabilities = capabilities,
						})
					end,
					jdtls = noop,
					["lua_ls"] = function()
						local lspconfig = require("lspconfig")
						lspconfig.lua_ls.setup({
							capabilities = capabilities,
							settings = {
								Lua = {
									diagnostics = {
										globals = { "bit", "vim", "it", "describe", "before_each", "after_each" },
									},
								},
							},
						})
					end,
				},
			})
			vim.api.nvim_create_autocmd("LspAttach", {
				desc = "LSP actions",
				callback = function(event)
					local opts = { buffer = event.buf }
					vim.keymap.set("n", "K", "<cmd>lua vim.lsp.buf.hover()<cr>", opts)
					vim.keymap.set("n", "gd", "<cmd>lua vim.lsp.buf.definition()<cr>", opts)
					vim.keymap.set("n", "gD", "<cmd>lua vim.lsp.buf.declaration()<cr>", opts)
					vim.keymap.set("n", "gi", "<cmd>lua vim.lsp.buf.implementation()<cr>", opts)
					vim.keymap.set("n", "go", "<cmd>lua vim.lsp.buf.type_definition()<cr>", opts)
					vim.keymap.set("n", "gr", "<cmd>lua vim.lsp.buf.references()<cr>", opts)
					vim.keymap.set("n", "gs", "<cmd>lua vim.lsp.buf.signature_help()<cr>", opts)
					vim.keymap.set("n", "<Leader>rn", "<cmd>lua vim.lsp.buf.rename()<cr>", opts)
					vim.keymap.set({ "n", "x" }, "<Leader>ca", "<cmd>lua vim.lsp.buf.code_action()<cr>", opts)
				end,
			})
			local cmp = require("cmp")
			cmp.setup({
				sources = {
					{ name = "nvim_lsp" },
					{ name = "buffer" },
					{ name = "path" },
				},
				mapping = cmp.mapping.preset.insert({
					["<CR>"] = cmp.mapping.confirm({ select = true }), -- Confirm selection on Enter
					["<C-Space>"] = cmp.mapping.complete(),
					["<C-u>"] = cmp.mapping.scroll_docs(-4),
					["<C-d>"] = cmp.mapping.scroll_docs(4),
				}),
				snippet = {
					expand = function(args)
						local insert = MiniSnippets.config.expand.insert or MiniSnippets.default_insert
						vim.notify(insert, "info")
						insert({ body = args.body }) -- Insert at cursor
						cmp.resubscribe({ "TextChangedI", "TextChangedP" })
						require("cmp.config").set_onetime({ sources = {} })
					end,
				},
				formatting = {
					fields = { "abbr", "kind", "menu" },
					format = function(entry, item)
						item.menu = ({
							nvim_lsp = "[LSP]",
							buffer = "[Buffer]",
							path = "[Path]",
						})[entry.source.name]
						return item
					end,
				},
				window = {
					completion = cmp.config.window.bordered(),
					documentation = cmp.config.window.bordered(),
				},
				preselect = cmp.PreselectMode.Item,
				completion = {
					completeopt = "menuone,noinsert", -- Controls the behavior of the completion menu
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
