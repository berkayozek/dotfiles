return {
	"ThePrimeagen/harpoon",
	event = "VimEnter",
	branch = "harpoon2",
	dependencies = { "nvim-lua/plenary.nvim" },
	keys = function()
		local harpoon = require("harpoon")
		local harpoon_extensions = require("harpoon.extensions")
		harpoon:extend(harpoon_extensions.builtins.highlight_current_file())
		harpoon:extend(harpoon_extensions.builtins.navigate_with_number())

		local keys = {
			{
				"<C-a>",
				function()
					harpoon:list():add()
				end,
				desc = "Harpoon mark file",
				mode = "n",
			},
			{
				"<leader>hc",
				function()
					harpoon:list():clear()
				end,
				desc = "Remove all files from Harpoon",
				mode = "n",
			},
			{
				"<C-e>",
				function()
					harpoon.ui:toggle_quick_menu(harpoon:list())
				end,
				desc = "Harpoon toggle quick menu",
				mode = "n",
			},

			{
				"<C-P>",
				function()
					harpoon:list():prev()
				end,
				desc = "Harpoon previous",
				mode = "n",
			},
			{
				"<C-N>",
				function()
					harpoon:list():next()
				end,
				desc = "Harpoon next",
				mode = "n",
			},
		}

		for i = 1, 4 do
			table.insert(keys, {
				"<leader>h" .. i,
				function()
					harpoon:list():select(i)
				end,
				desc = "Harpoon to file " .. i,
			})
		end
		return keys
	end,
	opts = {},
}
