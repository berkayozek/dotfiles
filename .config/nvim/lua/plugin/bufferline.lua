return {
	"akinsho/bufferline.nvim",
	lazy = false,
	dependencies = {
		"nvim-tree/nvim-web-devicons",
		"catppuccin/nvim",
	},
	config = function()
		local mocha = require("catppuccin.palettes").get_palette("mocha")
		local bufferline = require("bufferline")
		bufferline.setup({
			style_preset = bufferline.style_preset.mnimal,
			highlights = require("catppuccin.groups.integrations.bufferline").get({
				styles = { "italic", "bold" },
				custom = {
					all = {
						fill = { bg = "#000000" },
					},
					mocha = {
						background = { fg = mocha.text },
					},
					latte = {
						background = { fg = "#000000" },
					},
				},
			}),
			options = {
				max_name_length = 18,
				show_buffer_close_icons = false,
				show_close_icon = false,
			},
		})
	end,
	keys = {
		{ "<Leader>1", "<Cmd>BufferLineGoToBuffer 1<CR>", desc = "Go to Buffer 1" },
		{ "<Leader>2", "<Cmd>BufferLineGoToBuffer 2<CR>", desc = "Go to Buffer 2" },
		{ "<Leader>3", "<Cmd>BufferLineGoToBuffer 3<CR>", desc = "Go to Buffer 3" },
		{ "<Leader>4", "<Cmd>BufferLineGoToBuffer 4<CR>", desc = "Go to Buffer 4" },
		{ "<Leader>5", "<Cmd>BufferLineGoToBuffer 5<CR>", desc = "Go to Buffer 5" },
		{ "<Leader>6", "<Cmd>BufferLineGoToBuffer 6<CR>", desc = "Go to Buffer 6" },
		{ "<Leader>7", "<Cmd>BufferLineGoToBuffer 7<CR>", desc = "Go to Buffer 7" },
		{ "<Leader>8", "<Cmd>BufferLineGoToBuffer 8<CR>", desc = "Go to Buffer 8" },
		{ "<Leader>9", "<Cmd>BufferLineGoToBuffer 9<CR>", desc = "Go to Buffer 9" },
		{ "<Leader>$", "<Cmd>BufferLineGoToBuffer -1<CR>", desc = "Go to last Buffer" },
		{ "<Leader>l", "<Cmd>BufferLineCycleNext<CR>", desc = "Cycle to next buffer" },
		{ "<Leader>h", "<Cmd>BufferLineCyclePrev<CR>", desc = "Cycle to previous buffer" },
		{ "<Leader>gb", "<Cmd>BufferLinePick<CR>", desc = "Open bufferline pick" },
		{ "<Leader>gB", "<Cmd>BufferLineClose<CR>", desc = "Close bufferline pick" },
		{ "<Leader>bco", "<Cmd>BufferLineCloseOthers<CR>", desc = "Close all other visible buffers" },
	},
}
