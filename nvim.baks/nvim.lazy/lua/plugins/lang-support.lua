return {

	{
		"nvim-treesitter/nvim-treesitter",
		event = "BufEnter",
		run = ":TSUpdate",
		opts = {
			highlight = { enable = true },
			indent = { enable = true },
			ensure_installed = {
				"bash",
				"c",
				"html",
				"javascript",
				"json",
				"lua",
				"luadoc",
				"luap",
				"markdown",
				"markdown_inline",
				"python",
				"query",
				"regex",
				"tsx",
				"typescript",
				"vim",
				"vimdoc",
				"yaml",
			},

			incremental_selection = {
				enable = true,
				keymaps = {
					init_selection = "<C-space>",
					node_incremental = "<C-space>",
					scope_incremental = false,
					node_decremental = "<bs>",
				},
			},
		},
		---@param opts TSConfig
		config = function(_, opts)
			if type(opts.ensure_installed) == "table" then
				---@type table<string, boolean>
				local added = {}
				opts.ensure_installed = vim.tbl_filter(function(lang)
					if added[lang] then
						return false
					end
					added[lang] = true
					return true
				end, opts.ensure_installed)
			end
			require("nvim-treesitter.configs").setup(opts)
		end,
	},

	{ "vim-pandoc/vim-markdownfootnotes", ft = { "markdown" } },
	{ "godlygeek/tabular", cmd = { "Tabularize" } },

	{
		"iamcco/markdown-preview.nvim",
		run = "cd app && npm install",
		ft = { "markdown" },
	},
	{ "preservim/vim-markdown", ft = { "markdown" } },
	{ "jeetsukumaran/vim-pythonsense", ft = { "python" } },
	{ "Vimjas/vim-python-pep8-indent", ft = { "python" } },
	{ "neovim/nvim-lspconfig", after = "cmp-nvim-lsp" },
	{ "j-hui/fidget.nvim", after = "nvim-lspconfig" },

	{ "rhysd/vim-grammarous", ft = { "markdown" } },
	{ "ii14/emmylua-nvim", ft = "lua" },
	{ "vlime/vlime", rtp = "vim/", ft = { "lisp" } },
	{ "tmux-plugins/vim-tmux", ft = { "tmux" } },
}
