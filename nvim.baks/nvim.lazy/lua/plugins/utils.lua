return {
	{ "lewis6991/impatient.nvim", priority = 1000 },

	{ "nvim-tree/nvim-web-devicons", event = "VimEnter" },
	{ "chrisbra/unicode.vim", event = "VimEnter" },

	{ "tpope/vim-eunuch", cmd = { "Rename", "Delete" } },
	{ "tpope/vim-repeat", event = "VimEnter" },
	{ "tpope/vim-fugitive", event = "User InGitRepo" },

	{ "nvim-zh/better-escape.vim", event = { "InsertEnter" } },

	{ "lyokha/vim-xkbswitch", event = { "InsertEnter" } },
	{ "rbong/vim-flog", dependencies = "tpope/vim-fugitive", cmd = { "Flog" } },
	{ "christoomey/vim-conflicted", dependencies = "tpope/vim-fugitive", cmd = { "Conflicted" } },
	{
		"ruifm/gitlinker.nvim",
		dependencies = "nvim-lua/plenary.nvim",
		event = "User InGitRepo",
	},

	{ "onsails/lspkind-nvim", event = "VimEnter" },
	{ "hrsh7th/nvim-cmp", after = "lspkind-nvim" },

	{ "hrsh7th/cmp-nvim-lsp", after = "nvim-cmp" },
	{ "hrsh7th/cmp-path", after = "nvim-cmp" },
	{ "hrsh7th/cmp-buffer", after = "nvim-cmp" },
	{ "hrsh7th/cmp-omni", after = "nvim-cmp" },
	{ "quangnguyen30192/cmp-nvim-ultisnips", after = { "nvim-cmp", "ultisnips" } },

	{ "hrsh7th/cmp-emoji", after = "nvim-cmp" },
	{ "machakann/vim-swap", event = "VimEnter" },
	{ "907th/vim-auto-save", event = "InsertEnter" },

	{
		"rcarriga/nvim-notify",
		event = "BufEnter",
		-- config = function()
		-- 	vim.defer_fn(function()
		-- 		require("nvim-notify")
		-- 	end, 2000)
		-- end,
	},
	{ "tyru/open-browser.vim", event = "VimEnter" },
	{ "andymass/vim-matchup", event = "VimEnter" },
	{ "tpope/vim-scriptease", cmd = { "Scriptnames", "Message", "Verbose" } },
	{ "skywind3000/asyncrun.vim", opt = true, cmd = { "AsyncRun" } },
	{ "cespare/vim-toml", ft = { "toml" }, branch = "main" },
}
