local workspaces = {
	{
		name = "personal",
		path = "~/Documents/notes",
		backup = true,
	},
	{
		name = "work",
		path = "~/Documents/notes-work",
		backup = false,
	},
}

require("util/obsidian_utils").setup_custom_obsidian_commands(workspaces)

return {
	"obsidian-nvim/obsidian.nvim",
	version = "*",
	ft = "markdown",
	dependencies = {
		"nvim-lua/plenary.nvim",
		"folke/snacks.nvim",
	},
	opts = {
		follow_url_func = function(url)
			vim.fn.jobstart({ "open", url })
		end,
		daily_notes = {
			folder = "dailies",
		},
		workspaces = workspaces,
		ui = {
			enable = false,
		},
		completion = {
			nvim_cmp = false,
			blink = true,
		},
		picker = {
			name = "snacks.pick",
		},
		note_path_func = function(spec)
			local file_name = spec.title or spec.id
			local path = spec.dir / file_name
			return path:with_suffix(".md")
		end,
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
		-- Custom mapping for switching workspaces
		{
			"obw",
			"<cmd>ObsidianSwitchWorkspace<CR>",
			desc = "Switch Workspace",
		},
	},
}
