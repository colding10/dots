return {
	{ "Yggdroot/LeaderF", cmd = "Leaderf", run = ":LeaderfInstallCExtension" },
	{
		"nvim-telescope/telescope.nvim",
		cmd = "Telescope",
		dependencies = { { "nvim-lua/plenary.nvim" } },
	},
	{ "nvim-telescope/telescope-symbols.nvim", after = "telescope.nvim" },
	{
		"kevinhwang91/nvim-hlslens",
		branch = "main",
		keys = { { "n", "*" }, { "n", "#" }, { "n", "n" }, { "n", "N" } },
		config = [[require('config.hlslens')]],
	},
	{
		"ibhagwan/fzf-lua",
		-- optional for icon support
		dependencies = { "nvim-tree/nvim-web-devicons" },
	},
}
