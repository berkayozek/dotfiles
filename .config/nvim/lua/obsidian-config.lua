require("obsidian").setup({
    workspaces = {
        {
            name = "personal",
            path = "~/Documents/notes",
        }
    },
    ui = {
        enable = false
    }
})

local which_key = require("which-key")

which_key.add({
  { "ob", group = "Obsidian", nowait = true, remap = false },
  { "obO", "<cmd>ObsidianOpen<CR>", desc = "Open" },
  { "obn", "<cmd>ObsidianNew<CR>", desc = "New" },
  { "obo", "<cmd>ObsidianQuickSwitch<CR>", desc = "Quick Switch" },
  { "obf", "<cmd>ObsidianFollowLink<CR>", desc = "Follow Link" },
  { "obb", "<cmd>ObsidianBacklinks<CR>", desc = "Backlinks" },
  { "obd", "<cmd>ObsidianToday<CR>", desc = "Today's Daily note" },
  { "oby", "<cmd>ObsidianYesterday<CR>", desc = "Yesterday's Daily note" },
  { "obT", "<cmd>ObsidianTomorrow<CR>", desc = "Tomorrow's Daily note" },
  { "obt", "<cmd>ObsidianTemplate<CR>", desc = "Template" },
  { "obs", "<cmd>ObsidianSearch<CR>", desc = "Search" },
  { "obl", "<cmd>ObsidianLink<CR>", desc = "Link" },
  { "obL", "<cmd>ObsidianLinkNew<CR>", desc = "Link New" },
  { "obp", "<cmd>ObsidianPasteImg<CR>", desc = "Paste Img" },
  { "obr", "<cmd>ObsidianRename<CR>", desc = "Rename" },
  { "obR", "<cmd>ObsidianRename --dry-run<CR>", desc = "Rename (dry-run)" },
  { "obc", "<cmd>lua require('obsidian').util.toggle_checkbox()<CR>", desc = "Toggle checkbox" },
  {
    mode = { "v" },
    { "obr", "<Esc><Cmd>lua require('obsidian').util.toggle_checkbox()<CR>", desc = "Toggle checkbox (Visual)" },
  },
})

