return {
	"folke/which-key.nvim",
	event = "VeryLazy",
	opts = {
		plugins = {
			presets = {
				motions = false,
				g = false
			} -- This fix mapping for fold when press f and nothing show up
		},
		window = {
			margin = { 1, 0, 2, 0 }, -- extra window margin [top, right, bottom, left]
			padding = { 1, 2, 1, 2 }, -- extra window padding [top, right, bottom, left]
			winblend = 5            -- value between 0-100 0 for fully opaque and 100 for fully transparent
		},
		layout = {
			height = {
				min = 3,
				max = 25
			}, -- min and max height of the columns
			width = {
				min = 20,
				max = 50
			},               -- min and max width of the columns
			spacing = 5,     -- spacing between columns
			align = "center" -- align columns left, center or right
		}
	},
	config = function(_, opts)
		local wk = require("which-key")
		wk.setup(opts)
		wk.register({})
	end
}
