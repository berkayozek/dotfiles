return {
	"epwalsh/obsidian.nvim",
	version = "*",
	lazy = true,
	dependencies = {
		"nvim-lua/plenary.nvim",
	},
	opts = {
		workspaces = {
			{
				name = "personal",
				path = "~/Documents/notes",
			},
		},
		ui = {
			enable = false,
		},
	},
	keys = {
		{ "obo", "<cmd>ObsidianOpen<CR>", desc = "Open Obsidian" },
		{ "obn", "<cmd>ObsidianNew<CR>", desc = "Create a new note" },
		{ "obq", "<cmd>ObsidianQuickSwitch<CR>", desc = "Quick Switch" },
		{ "obf", "<cmd>ObsidianFollowLink<CR>", desc = "Follow Link" },
		{ "obb", "<cmd>ObsidianBacklinks<CR>", desc = "Backlinks" },
		{ "obt", "<cmd>ObsidianToday<CR>", desc = "Today's Daily Note" },
		{ "oby", "<cmd>ObsidianYesterday<CR>", desc = "Yesterday's Daily Note" },
		{ "obT", "<cmd>ObsidianTomorrow<CR>", desc = "Tomorrow's Daily Note" },
		{ "obl", "<cmd>ObsidianTemplate<CR>", desc = "Insert Template" },
		{ "obs", "<cmd>ObsidianSearch<CR>", desc = "Search Obsidian" },
		{ "obk", "<cmd>ObsidianLink<CR>", desc = "Create Link" },
		{ "obK", "<cmd>ObsidianLinkNew<CR>", desc = "Create New Link" },
		{ "obp", "<cmd>ObsidianPasteImg<CR>", desc = "Paste Image" },
		{ "obr", "<cmd>ObsidianRename<CR>", desc = "Rename Note" },
		{ "obR", "<cmd>ObsidianRename --dry-run<CR>", desc = "Dry-Run Rename" },
		{
			"obc",
			function()
				require("obsidian").util.toggle_checkbox()
			end,
			desc = "Toggle Checkbox",
		},
		-- Visual mode mapping for toggle checkbox
		{
			"obc",
			"<Esc><cmd>lua require('obsidian').util.toggle_checkbox()<CR>",
			mode = "v",
			desc = "Toggle Checkbox (Visual)",
		},
	},
}
