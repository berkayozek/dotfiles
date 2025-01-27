return {	
	{
		"mfussenegger/nvim-jdtls",
		ft = "java",
	},
	{
		"hrsh7th/nvim-cmp",
		event = "InsertEnter",
		config = function()
			local cmp = require("cmp")

			require("luasnip.loaders.from_vscode").lazy_load()

			cmp.setup({
				sources = {
					{ name = "nvim_lsp" },
					{ name = "luasnip" },
				},
				mapping = cmp.mapping.preset.insert({
					["<C-p>"] = cmp.mapping.select_prev_item(cmp_select),
					["<C-n>"] = cmp.mapping.select_next_item(cmp_select),
					["<C-y>"] = cmp.mapping.confirm({ select = true }),
					["<CR>"] = cmp.mapping.confirm({ select = true }), -- Confirm selection on Enter
					["<C-Space>"] = cmp.mapping.complete(),
					["<C-u>"] = cmp.mapping.scroll_docs(-4),
					["<C-d>"] = cmp.mapping.scroll_docs(4),
					["<Tab>"] = nil,
					["<S-Tab>"] = nil,
				}),
				snippet = {
					expand = function(args)
						vim.snippet.expand(args.body)
					end,
				},
				formatting = {
					fields = { "abbr", "kind", "menu" },
					format = function(entry, item)
						item.menu = ({
							nvim_lsp = "[LSP]",
							luasnip = "[Snippet]",
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
		"neovim/nvim-lspconfig",
		dependencies = {
			-- LSP Support
			"williamboman/mason.nvim", -- Optional
			"williamboman/mason-lspconfig.nvim", -- Optional

			-- Autocompletion
			"hrsh7th/nvim-cmp", -- Required
			"hrsh7th/cmp-nvim-lsp", -- Required
			"hrsh7th/cmp-buffer", -- Optional
			"hrsh7th/cmp-path", -- Optional
			"saadparwaiz1/cmp_luasnip", -- Optional
			"hrsh7th/cmp-nvim-lua", -- Optional

			-- Snippets
			"L3MON4D3/LuaSnip", -- Required
			"rafamadriz/friendly-snippets", -- Optional

			"stevearc/conform.nvim",
		},
		init = function()
            local mason = require("mason")
            local mason_lspconfig = require("mason-lspconfig")
			local lspconfig_defaults = require("lspconfig").util.default_config
            
            mason.setup({})
            mason_lspconfig.setup({
				ensure_installed = {
					"jdtls",
					"ts_ls",
					"pyright",
					"gopls",
					"clangd",
					"lemminx",
				},
				handlers = {
					-- this first function is the "default handler"
					-- it applies to every language server without a "custom handler"
					function(server_name)
						require("lspconfig")[server_name].setup({})
					end,

					-- this is the "custom handler" for `jdtls`
					-- noop is an empty function that doesn't do anything
					jdtls = function()
                    end,
				},
			})
			lspconfig_defaults.capabilities = vim.tbl_deep_extend(
				"force",
				lspconfig_defaults.capabilities,
				require("cmp_nvim_lsp").default_capabilities()
			)

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
					vim.keymap.set({ "n", "x" }, "<F3>", "<cmd>lua vim.lsp.buf.format({async = true})<cr>", opts)
					vim.keymap.set("n", "<Leader>ca", "<cmd>lua vim.lsp.buf.code_action()<cr>", opts)
					vim.keymap.set("x", "<Leader>ca", "<cmd>lua vim.lsp.buf.code_action()<cr>", opts)
				end,
			})	
		end,
	},
}
