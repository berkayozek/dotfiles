return {
	"OXY2DEV/markview.nvim",
	event = { "BufReadPre", "BufNewFile" },
	config = function()
		local presets = require("markview.presets")
		require("markview").setup({
			preview = {
				icon_provider = "mini",
			},
			markdown = {
				headings = presets.headings.arrowed,
				horizontal_rules = presets.horizontal_rules.thick
			},
		})
	end,
}
