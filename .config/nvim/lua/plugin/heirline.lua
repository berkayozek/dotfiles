return {
	"rebelot/heirline.nvim",
	dependencies = {
		"echasnovski/mini.nvim",
	},
	event = "VeryLazy",
	config = function()
		local heirline = require("heirline")
		local conditions = require("heirline.conditions")
		local utils = require("heirline.utils")
		local local_utils = require("util/heirline_utils")

		local colors = require("catppuccin.palettes").get_palette("mocha")
		heirline.load_colors(colors)

		local Align = { provider = "%=" }
		local Space = { provider = " " }

		local LeftSeparator = {
			provider = "█",
			hl = { fg = colors.blue },
		}

		local RightSeparator = {
			provider = "█",
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
			provider = "█",
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
			provider = "█",
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
				local is_file = type(filename) == "string"
				local category = is_file and "file" or "extension"

				self.icon, self.icon_color_group =
					require("mini.icons").get(category, is_file and filename or extension)
				self.icon_color = vim.api.nvim_get_hl(0, { name = self.icon_color_group })
			end,
			provider = function(self)
				return self.icon and (self.icon .. " ")
			end,
			hl = function(self)
				return self.icon_color
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
				error_icon = vim.diagnostic.config()["signs"]["text"][vim.diagnostic.severity.ERROR],
				warn_icon = vim.diagnostic.config()["signs"]["text"][vim.diagnostic.severity.WARN],
				info_icon = vim.diagnostic.config()["signs"]["text"][vim.diagnostic.severity.INFO],
				hint_icon = vim.diagnostic.config()["signs"]["text"][vim.diagnostic.severity.HINT],
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
					return self.errors > 0 and (self.error_icon .. " " .. self.errors .. " ")
				end,
				hl = { fg = "red", bold = true },
			},
			{
				provider = function(self)
					return self.warnings > 0 and (self.warn_icon .. " " .. self.warnings .. " ")
				end,
				hl = { fg = "yellow", bold = true },
			},
			{
				provider = function(self)
					return self.info > 0 and (self.info_icon .. " " .. self.info .. " ")
				end,
				hl = { fg = "sapphire", bold = true },
			},
			{
				provider = function(self)
					return self.hints > 0 and (self.hint_icon .. " " .. self.hints)
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
			Git,
			Space,
			Diagnostics,
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

		local TablineBufnr = {
			provider = function(self)
				local visible_buffers = local_utils.get_visible_buffers()

				local current_buf_idx = 1
				for i, buf in ipairs(visible_buffers) do
					if buf == self.bufnr then
						current_buf_idx = i
						break
					end
				end

				return tostring(current_buf_idx) .. " "
			end,
			hl = "Comment",
		}

		local TablineFileName = {
			provider = function(self)
				if self.file_path == "" then
					return ""
				end
				local filename = vim.fn.fnamemodify(self.filename, ":p:t")
				for _, bufnr in ipairs(vim.api.nvim_list_bufs()) do
					local file_path = vim.api.nvim_buf_get_name(bufnr)
					local file_name = vim.fn.fnamemodify(file_path, ":t")
					if filename == file_name and self.bufnr ~= bufnr then
						return vim.fn.fnamemodify(self.filename, ":.")
					end
				end
				return vim.fn.fnamemodify(self.filename, ":p:t")
			end,

			hl = function(self)
				return { bold = self.is_active or self.is_visible }
			end,
		}

		local TablineFileFlags = {
			{
				condition = function(self)
					return vim.api.nvim_get_option_value("modified", { buf = self.bufnr })
				end,
				provider = "[+]",
				hl = { fg = "green" },
			},
			{
				condition = function(self)
					return not vim.api.nvim_get_option_value("modifiable", { buf = self.bufnr })
						or vim.api.nvim_get_option_value("readonly", { buf = self.bufnr })
				end,
				provider = function(self)
					if vim.api.nvim_get_option_value("buftype", { buf = self.bufnr }) == "terminal" then
						return "  "
					else
						return ""
					end
				end,
				hl = { fg = "orange" },
			},
		}

		local TablineFileNameBlock = {
			init = function(self)
				self.filename = vim.api.nvim_buf_get_name(self.bufnr)
			end,
			hl = function(self)
				if self.is_active then
					return "TabLineSel"
				else
					return "TabLine"
				end
			end,
			on_click = {
				callback = function(_, minwid, _, button)
					if button == "m" then -- close on mouse middle click
						vim.schedule(function()
							vim.api.nvim_buf_delete(minwid, { force = false })
						end)
					else
						vim.api.nvim_win_set_buf(0, minwid)
					end
				end,
				minwid = function(self)
					return self.bufnr
				end,
				name = "heirline_tabline_buffer_callback",
			},
			TablineBufnr,
			FileIcon,
			TablineFileName,
			TablineFileFlags,
		}

		local TablineBufferBlock = utils.surround({ "", "" }, function(self)
			if self.is_active then
				return utils.get_highlight("TabLineSel").bg
			else
				return utils.get_highlight("TabLine").bg
			end
		end, { TablineFileNameBlock })

		local BufferLine = utils.make_buflist(
			TablineBufferBlock,
			{ provider = "", hl = { fg = "gray" } },
			{ provider = "", hl = { fg = "gray" } }
		)

		local_utils.setup_shortcuts()
		vim.o.showtabline = 2

		require("heirline").setup({
			tabline = BufferLine,
			statusline = StatusLines,
		})
	end,
}
