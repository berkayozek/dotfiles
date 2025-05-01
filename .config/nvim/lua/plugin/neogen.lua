return {
	"danymat/neogen",
	opts = {},
	keys = {
		{
			"<Leader>ng",
			function()
				require("neogen").generate()
			end,
			desc = "Generate document",
			mode = "n",
		},
		{
			"<C-l>",
			function()
				require("neogen").jump_next()
			end,
			desc = "Jumpt next placeholder",
			mode = "i",
		},
		{
			"<C-h>",
			function()
				require("neogen").jump_prev()
			end,
			desc = "Jumpt previous placeholder",
			mode = "i",
		},
	},
}
