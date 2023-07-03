return {
	"danymat/neogen",
	keys = {
		{
			"<leader>ga",
			function()
				require("neogen").generate({})
			end,
		},
	},
	opts = {
		snippet_engine = "luasnip",
	},
}
