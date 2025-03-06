return {
	"rebelot/heirline.nvim",
	dependencies = {
		"nvim-tree/nvim-web-devicons",
	},
	event = "VeryLazy",
	config = function()
		local heirline = require("heirline")
		local conditions = require("heirline.conditions")
		local utils = require("heirline.utils")

		local colors = require("catppuccin.palettes").get_palette("mocha")
		heirline.load_colors(colors)

		local Align = { provider = "%=" }
		local Space = { provider = " " }

		local LeftSeparator = {
			provider = "",
			hl = { fg = colors.blue },
		}

		local RightSeparator = {
			provider = "",
			hl = { fg = colors.blue },
		}

		local VIMODE_COLORS = {
			["n"] = colors.blue,
			["nov"] = colors.pink,
			["noV"] = colors.pink,
			["no"] = colors.pink,
			["niI"] = colors.blue,
			["niR"] = colors.blue,
			["niV"] = colors.blue,
			["v"] = colors.mauve,
			["vs"] = colors.mauve,
			["V"] = colors.lavender,
			["Vs"] = colors.lavender,
			[""] = colors.yellow,
			["s"] = colors.teal,
			["S"] = colors.teal,
			["i"] = colors.green,
			["ic"] = colors.green,
			["ix"] = colors.green,
			["R"] = colors.flamingo,
			["Rc"] = colors.flamingo,
			["Rv"] = colors.rosewater,
			["Rx"] = colors.flamingo,
			["c"] = colors.peach,
			["cv"] = colors.peach,
			["ce"] = colors.peach,
			["r"] = colors.teal,
			["rm"] = colors.sky,
			["r?"] = colors.maroon,
			["!"] = colors.maroon,
			["t"] = colors.red,
			["nt"] = colors.red,
			["null"] = colors.pink,
		}

		local ViModeSepLeft = {
			init = function(self)
				self.mode = vim.api.nvim_get_mode().mode
				if not self.once then
					vim.api.nvim_create_autocmd("ModeChanged", {
						pattern = "*:*o",
						command = "redrawstatus",
					})
					self.once = true
				end
			end,
			provider = "",
			hl = function(self)
				local mode = self.mode:sub(1, 1)
				return { fg = VIMODE_COLORS[mode], bg = colors.mantle }
			end,
			update = {
				"ModeChanged",
			},
		}

		local ViMode = {
			init = function(self)
				self.mode = vim.fn.mode()
			end,
			provider = function(self)
				local mode_map = {
					n = "NORMAL",
					i = "INSERT",
					v = "VISUAL",
					V = "V-LINE",
					[""] = "V-BLOCK",
					c = "COMMAND",
					s = "SELECT",
					S = "S-LINE",
					R = "REPLACE",
					t = "TERMINAL",
				}
				return " " .. mode_map[self.mode] .. " "
			end,
			hl = function(self)
				local color = VIMODE_COLORS[self.mode] or "white"
				return { fg = "black", bg = color, bold = true }
			end,
			update = {
				"ModeChanged",
				pattern = "*:*",
				callback = vim.schedule_wrap(function()
					vim.cmd("redrawstatus")
				end),
			},
		}

		local ViModeSepRight = {
			init = function(self)
				self.mode = vim.api.nvim_get_mode().mode
				if not self.once then
					vim.api.nvim_create_autocmd("ModeChanged", {
						pattern = "*:*o",
						command = "redrawstatus",
					})
					self.once = true
				end
			end,
			provider = "",
			hl = function(self)
				local mode = self.mode:sub(1, 1)
				return { fg = VIMODE_COLORS[mode], bg = colors.mantle }
			end,
			update = {
				"ModeChanged",
			},
		}

		local FileType = {
			provider = function()
				return string.lower(vim.bo.filetype)
			end,
			hl = { fg = utils.get_highlight("Type").fg, bold = true },
		}

		local FileNameBlock = {
			init = function(self)
				self.filename = vim.api.nvim_buf_get_name(0)
			end,
		}

		local FileIcon = {
			init = function(self)
				local filename = self.filename
				local extension = vim.fn.fnamemodify(filename, ":e")
				self.icon, self.icon_color =
					require("nvim-web-devicons").get_icon_color(filename, extension, { default = true })
			end,
			provider = function(self)
				return self.icon and (self.icon .. " ")
			end,
			hl = function(self)
				return { fg = self.icon_color }
			end,
		}

		local FileName = {
			provider = function(self)
				local filename = vim.fn.fnamemodify(self.filename, ":.")
				if filename == "" then
					return "[No Name]"
				end
				if not conditions.width_percent_below(#filename, 0.25) then
					filename = vim.fn.pathshorten(filename)
				end
				return filename
			end,
			hl = { fg = utils.get_highlight("Directory").fg },
		}

		local HelpFileName = {
			condition = function()
				return vim.bo.filetype == "help"
			end,
			provider = function()
				local filename = vim.api.nvim_buf_get_name(0)
				return vim.fn.fnamemodify(filename, ":t")
			end,
			hl = { fg = colors.blue },
		}

		local FileFlags = {
			{
				condition = function()
					return vim.bo.modified
				end,
				provider = "[+]",
				hl = { fg = "green" },
			},
			{
				condition = function()
					return not vim.bo.modifiable or vim.bo.readonly
				end,
				provider = "",
				hl = { fg = "orange" },
			},
		}

		local FileNameModifer = {
			hl = function()
				if vim.bo.modified then
					return { fg = "cyan", bold = true, force = true }
				end
			end,
		}

		-- let's add the children to our FileNameBlock component
		FileNameBlock = utils.insert(
			FileNameBlock,
			FileIcon,
			utils.insert(FileNameModifer, FileName), -- a new table where FileName is a child of FileNameModifier
			FileFlags,
			{ provider = "%<" } -- this means that the statusline is cut here when there's not enough space
		)

		local Diagnostics = {

			condition = conditions.has_diagnostics(),

			static = {
				error_icon = vim.fn.sign_getdefined("DiagnosticSignError")[1].text,
				warn_icon = vim.fn.sign_getdefined("DiagnosticSignWarn")[1].text,
				info_icon = vim.fn.sign_getdefined("DiagnosticSignInfo")[1].text,
				hint_icon = vim.fn.sign_getdefined("DiagnosticSignHint")[1].text,
			},

			init = function(self)
				self.errors = #vim.diagnostic.get(0, { severity = vim.diagnostic.severity.ERROR })
				self.warnings = #vim.diagnostic.get(0, { severity = vim.diagnostic.severity.WARN })
				self.hints = #vim.diagnostic.get(0, { severity = vim.diagnostic.severity.HINT })
				self.info = #vim.diagnostic.get(0, { severity = vim.diagnostic.severity.INFO })
			end,

			update = { "DiagnosticChanged", "BufEnter" },

			{
				provider = function(self)
					-- 0 is just another output, we can decide to print it or not!
					return self.errors > 0 and (self.error_icon .. self.errors .. " ")
				end,
				hl = { fg = "red" },
			},
			{
				provider = function(self)
					return self.warnings > 0 and (self.warn_icon .. self.warnings .. " ")
				end,
				hl = { fg = "yellow" },
			},
			{
				provider = function(self)
					return self.info > 0 and (self.info_icon .. self.info .. " ")
				end,
				hl = { fg = "sapphire" },
			},
			{
				provider = function(self)
					return self.hints > 0 and (self.hint_icon .. self.hints)
				end,
				hl = { fg = "sky" },
			},
		}

		local Git = {
			condition = conditions.is_git_repo,
			update = { "BufEnter", "WinEnter" },

			init = function(self)
				self.status_dict = vim.b.gitsigns_status_dict
				self.has_changes = self.status_dict.added ~= 0
					or self.status_dict.removed ~= 0
					or self.status_dict.changed ~= 0
			end,

			hl = { fg = "orange" },

			{ -- git branch name
				provider = function(self)
					return " " .. self.status_dict.head
				end,
				hl = { bold = true },
			},
			{
				condition = function(self)
					return self.has_changes
				end,
				provider = "(",
			},
			{
				provider = function(self)
					local count = self.status_dict.added or 0
					return count > 0 and ("+" .. count)
				end,
				hl = { fg = "green" },
			},
			{
				provider = function(self)
					local count = self.status_dict.removed or 0
					return count > 0 and ("-" .. count)
				end,
				hl = { fg = "red" },
			},
			{
				provider = function(self)
					local count = self.status_dict.changed or 0
					return count > 0 and ("~" .. count)
				end,
				hl = { fg = "yellow" },
			},
			{
				condition = function(self)
					return self.has_changes
				end,
				provider = ")",
			},
		}

		local Ruler = {
			provider = "%l:%L %c",
			hl = { fg = colors.base, bg = colors.blue, bold = true },
		}

		local LSPActive = {
			condition = conditions.lsp_attached,
			update = { "LspAttach", "LspDetach" },
			provider = function()
				local names = {}
				local clients = vim.lsp.get_clients({ bufnr = 0 })
				for _, server in pairs(clients) do
					table.insert(names, server.name)
				end
				return " [" .. table.concat(names, " ") .. "]"
			end,
			hl = { fg = "green", bold = true },
		}

		local DefaultStatusline = {
			ViModeSepLeft,
			ViMode,
			ViModeSepRight,
			Space,
			FileNameBlock,
			Space,
			Diagnostics,
			Space,
			Git,
			Align,
			LSPActive,
			Space,
			FileType,
			Space,
			LeftSeparator,
			Ruler,
			RightSeparator,
		}

		local InactiveStatusline = {
			condition = conditions.is_not_active,
			FileNameBlock,
			Align,
		}

		local NvimTreeStatusLine = {
			condition = function()
				return conditions.buffer_matches({
					filetype = { "NvimTree" },
				})
			end,
		}

		local SpecialStatusline = {
			condition = function()
				return conditions.buffer_matches({
					buftype = { "nofile", "prompt", "help", "quickfix" },
					filetype = { "^git.*", "fugitive" },
				})
			end,

			FileType,
			Space,
			HelpFileName,
			Align,
		}

		local StatusLines = {
			fallthrough = false,
			NvimTreeStatusLine,
			SpecialStatusline,
			InactiveStatusline,
			DefaultStatusline,
		}

		require("heirline").setup({
			statusline = StatusLines,
		})
	end,
}
