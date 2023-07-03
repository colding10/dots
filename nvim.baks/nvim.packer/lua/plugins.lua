local api = vim.api
local fn = vim.fn

local utils = require("utils")

-- The root dir to install all plugins. Plugins are under opt/ or start/ sub-directory.
vim.g.plugin_home = fn.stdpath("data") .. "/site/pack/packer"

local function packer_ensure_install()
	-- Where to install packer.nvim -- the package manager (we make it opt)
	local packer_dir = vim.g.plugin_home .. "/opt/packer.nvim"

	if fn.glob(packer_dir) ~= "" then
		return false
	end

	-- Auto-install packer in case it hasn't been installed.
	vim.api.nvim_echo({ { "Installing packer.nvim", "Type" } }, true, {})

	local packer_repo = "https://github.com/wbthomason/packer.nvim"
	local install_cmd = string.format("!git clone --depth=1 %s %s", packer_repo, packer_dir)
	vim.cmd(install_cmd)

	return true
end

local fresh_install = packer_ensure_install()

-- Load packer.nvim
vim.cmd("packadd packer.nvim")

local packer = require("packer")
local packer_util = require("packer.util")

-- check if firenvim is active
local firenvim_not_active = function()
	return not vim.g.started_by_firenvim
end

packer.startup({
	function(use)
		-- it is recommended to put impatient.nvim before any other plugins
		use({ "lewis6991/impatient.nvim", config = [[require('impatient')]] })

		use({ "wbthomason/packer.nvim", opt = true })

		use({ "onsails/lspkind-nvim", event = "VimEnter" })
		use({ "hrsh7th/nvim-cmp", after = "lspkind-nvim", config = [[require('config.nvim-cmp')]] })

		use({ "hrsh7th/cmp-nvim-lsp", after = "nvim-cmp" })
		use({ "hrsh7th/cmp-path", after = "nvim-cmp" })
		use({ "hrsh7th/cmp-buffer", after = "nvim-cmp" })
		use({ "hrsh7th/cmp-omni", after = "nvim-cmp" })
		use({ "quangnguyen30192/cmp-nvim-ultisnips", after = { "nvim-cmp", "ultisnips" } })

		use({ "hrsh7th/cmp-emoji", after = "nvim-cmp" })

		use({ "neovim/nvim-lspconfig", after = "cmp-nvim-lsp", config = [[require('config.lsp')]] })

		use({
			"nvim-treesitter/nvim-treesitter",
			event = "BufEnter",
			run = ":TSUpdate",
			config = [[require('config.treesitter')]],
		})

		-- Python indent (follows the PEP8 style)
		use({ "Vimjas/vim-python-pep8-indent", ft = { "python" } })

		-- Python-related text object
		use({ "jeetsukumaran/vim-pythonsense", ft = { "python" } })

		use({ "machakann/vim-swap", event = "VimEnter" })

		-- IDE for Lisp
		if utils.executable("sbcl") then
			-- use 'kovisoft/slimv'
			use({ "vlime/vlime", rtp = "vim/", ft = { "lisp" } })
		end

		-- Super fast buffer jump
		use({
			"phaazon/hop.nvim",
			event = "VimEnter",
			config = function()
				vim.defer_fn(function()
					require("config.nvim_hop")
				end, 2000)
			end,
		})

		-- Show match number and index for searching
		use({
			"kevinhwang91/nvim-hlslens",
			branch = "main",
			keys = { { "n", "*" }, { "n", "#" }, { "n", "n" }, { "n", "N" } },
			config = [[require('config.hlslens')]],
		})

		-- File search, tag search and more
		use({ "Yggdroot/LeaderF", cmd = "Leaderf", run = ":LeaderfInstallCExtension" })

		use({
			"nvim-telescope/telescope.nvim",
			cmd = "Telescope",
			requires = { { "nvim-lua/plenary.nvim" } },
		})
		-- search emoji and other symbols
		use({ "nvim-telescope/telescope-symbols.nvim", after = "telescope.nvim" })

		-- A list of colorscheme plugin you may want to try. Find what suits you.
		use({ "navarasu/onedark.nvim", opt = true })
		use({ "sainnhe/edge", opt = true })
		use({ "sainnhe/sonokai", opt = true })
		use({ "sainnhe/gruvbox-material", opt = true })
		use({ "shaunsingh/nord.nvim", opt = true })
		use({ "sainnhe/everforest", opt = true })
		use({ "EdenEast/nightfox.nvim", opt = true })
		use({ "rebelot/kanagawa.nvim", opt = true })
		use({ "catppuccin/nvim", as = "catppuccin", opt = true })
		use({ "rose-pine/neovim", as = "rose-pine", opt = true })
		use({ "olimorris/onedarkpro.nvim", opt = true })
		use({ "tanvirtin/monokai.nvim", opt = true })
		use({ "marko-cerovac/material.nvim", opt = true })

		use({ "nvim-tree/nvim-web-devicons", event = "VimEnter" })

		use({
			"nvim-lualine/lualine.nvim",
			event = "VimEnter",
			cond = firenvim_not_active,
			config = [[require('config.statusline')]],
		})

		use({
			"akinsho/bufferline.nvim",
			event = "VimEnter",
			cond = firenvim_not_active,
			config = [[require('config.bufferline')]],
		})

		use({
			"lukas-reineke/indent-blankline.nvim",
			event = "VimEnter",
			config = [[require('config.indent-blankline')]],
		})

		-- Highlight URLs inside vim
		use({ "itchyny/vim-highlighturl", event = "VimEnter" })

		-- notification plugin
		use({
			"rcarriga/nvim-notify",
			event = "BufEnter",
			config = function()
				vim.defer_fn(function()
					require("config.nvim-notify")
				end, 2000)
			end,
		})
		use({
			"akinsho/toggleterm.nvim",
			tag = "*",
			config = function()
				require("toggleterm").setup()
			end,
		})

		use({
			"ibhagwan/fzf-lua",
			-- optional for icon support
			requires = { "nvim-tree/nvim-web-devicons" },
		})

		-- For Windows and Mac, we can open an URL in the browser. For Linux, it may
		-- not be possible since we maybe in a server which disables GUI.

		-- open URL in browser
		use({ "tyru/open-browser.vim", event = "VimEnter" })

		-- Only install these plugins if ctags are installed on the system
		if utils.executable("ctags") then
			-- show file tags in vim window
			use({ "liuchengxu/vista.vim", cmd = "Vista" })
		end

		-- Snippet engine and snippet template
		use({ "SirVer/ultisnips", event = "InsertEnter" })
		use({ "honza/vim-snippets", after = "ultisnips" })

		-- Automatic insertion and deletion of a pair of characters
		use({ "Raimondi/delimitMate", event = "InsertEnter" })

		-- Comment plugin
		use({ "tpope/vim-commentary", event = "VimEnter" })

		-- Multiple cursor plugin like Sublime Text?
		-- use 'mg979/vim-visual-multi'

		-- Autosave files on certain events
		use({ "907th/vim-auto-save", event = "InsertEnter" })

		-- Show undo history visually
		use({ "simnalamburt/vim-mundo", cmd = { "MundoToggle", "MundoShow" } })

		-- better UI for some nvim actions
		use({ "stevearc/dressing.nvim" })
		use({ "mrjones2014/nvim-ts-rainbow" })
		-- Manage your yank history
		use({
			"gbprod/yanky.nvim",
			config = [[require('config.yanky')]],
		})

		-- Dashboard
		use({
			"goolord/alpha-nvim",
			requires = { "BlakeJC94/alpha-nvim-fortune" },
			config = function()
				require("config.alpha")
			end,
		})

		-- Tetris
		use({
			"alec-gibson/nvim-tetris",
		})
		-- Minesweeper
		use({
			"seandewar/nvimesweeper",
		})

		-- Handy unix command inside Vim (Rename, Move etc.)
		use({ "tpope/vim-eunuch", cmd = { "Rename", "Delete" } })

		-- Repeat vim motions
		use({ "tpope/vim-repeat", event = "VimEnter" })

		use({ "nvim-zh/better-escape.vim", event = { "InsertEnter" } })

		use({ "lyokha/vim-xkbswitch", event = { "InsertEnter" } })

		-- Auto format tools
		use({ "sbdchd/neoformat", cmd = { "Neoformat" } })

		-- Git command inside vim
		use({ "tpope/vim-fugitive", event = "User InGitRepo", config = [[require('config.fugitive')]] })

		-- Better git log display
		use({ "rbong/vim-flog", requires = "tpope/vim-fugitive", cmd = { "Flog" } })

		use({ "christoomey/vim-conflicted", requires = "tpope/vim-fugitive", cmd = { "Conflicted" } })

		use({
			"ruifm/gitlinker.nvim",
			requires = "nvim-lua/plenary.nvim",
			event = "User InGitRepo",
			config = [[require('config.git-linker')]],
		})

		-- Show git change (change, delete, add) signs in vim sign column
		use({ "lewis6991/gitsigns.nvim", config = [[require('config.gitsigns')]] })

		-- Better git commit experience
		use({ "rhysd/committia.vim", opt = true, setup = [[vim.cmd('packadd committia.vim')]] })

		use({ "kevinhwang91/nvim-bqf", ft = "qf", config = [[require('config.bqf')]] })

		-- Another markdown plugin
		use({ "preservim/vim-markdown", ft = { "markdown" } })

		-- Faster footnote generation
		use({ "vim-pandoc/vim-markdownfootnotes", ft = { "markdown" } })
		use({ "andweeb/presence.nvim" })
		-- Vim tabular plugin for manipulate tabular, required by markdown plugins
		use({ "godlygeek/tabular", cmd = { "Tabularize" } })

		-- Markdown previewing (only for Mac and Windows)

		use({
			"iamcco/markdown-preview.nvim",
			run = "cd app && npm install",
			ft = { "markdown" },
		})

		use({"ggandor/leap.nvim"})
		use({ "folke/zen-mode.nvim", cmd = "ZenMode", config = [[require('config.zen-mode')]] })

		use({ "rhysd/vim-grammarous", ft = { "markdown" } })

		use({ "chrisbra/unicode.vim", event = "VimEnter" })
		use({ "ckipp01/stylua-nvim" })

		-- Additional powerful text object for vim, this plugin should be studied
		-- carefully to use its full power
		use({ "wellle/targets.vim", event = "VimEnter" })

		-- Plugin to manipulate character pairs quickly
		use({ "machakann/vim-sandwich", event = "VimEnter" })

		-- Add indent object for vim (useful for languages like Python)
		use({ "michaeljsmith/vim-indent-object", event = "VimEnter" })

		-- Only use these plugin on Windows and Mac and when LaTeX is installed
		if utils.executable("latex") then
			use({ "lervag/vimtex", ft = { "tex" } })
		end

		-- Since tmux is only available on Linux and Mac, we only enable these plugins
		-- for Linux and Mac
		if utils.executable("tmux") then
			-- .tmux.conf syntax highlighting and setting check
			use({ "tmux-plugins/vim-tmux", ft = { "tmux" } })
		end

		-- Modern matchit implementation
		use({ "andymass/vim-matchup", event = "VimEnter" })

		use({ "tpope/vim-scriptease", cmd = { "Scriptnames", "Message", "Verbose" } })

		-- Asynchronous command execution
		use({ "skywind3000/asyncrun.vim", opt = true, cmd = { "AsyncRun" } })

		use({ "cespare/vim-toml", ft = { "toml" }, branch = "main" })

		use({
			"folke/persistence.nvim",
			event = "BufReadPre", -- this will only start session saving when an actual file was opened
			module = "persistence",
			config = function()
				require("persistence").setup()
			end,
		})

		-- Debugger plugin
		use({ "sakhnik/nvim-gdb", run = { "bash install.sh" }, opt = true, setup = [[vim.cmd('packadd nvim-gdb')]] })

		-- Session management plugin
		use({ "tpope/vim-obsession", cmd = "Obsession" })

		-- The missing auto-completion for cmdline!
		use({ "gelguy/wilder.nvim", opt = true, setup = [[vim.cmd('packadd wilder.nvim')]] })

		-- showing keybindings
		use({
			"folke/which-key.nvim",
			event = "VimEnter",
			config = function()
				vim.defer_fn(function()
					require("config.which-key")
				end, 2000)
			end,
		})

		-- show and trim trailing whitespaces
		use({ "jdhao/whitespace.nvim", event = "VimEnter" })
		-- file explorer
		use({
			"nvim-tree/nvim-tree.lua",
			requires = { "nvim-tree/nvim-web-devicons" },
			config = [[require('config.nvim-tree')]],
		})

		use({ "ii14/emmylua-nvim", ft = "lua" })

		use({ "j-hui/fidget.nvim", after = "nvim-lspconfig", config = [[require('config.fidget-nvim')]] })
	end,
	config = {
		max_jobs = 16,
		compile_path = packer_util.join_paths(fn.stdpath("data"), "site", "lua", "packer_compiled.lua"),
	},
})

-- For fresh install, we need to install plugins. Otherwise, we just need to require `packer_compiled.lua`.
if fresh_install then
  -- We run packer.sync() here, because only after packer.startup, can we know which plugins to install.
  -- So plugin installation should be done after the startup process.
  packer.sync()
else
  local status, _ = pcall(require, "packer_compiled")
  if not status then
    local msg = "File packer_compiled.lua not found: run PackerSync to fix!"
    vim.notify(msg, vim.log.levels.ERROR, { title = "nvim-config" })
  end
end

-- Auto-generate packer_compiled.lua file
api.nvim_create_autocmd({ "BufWritePost" }, {
  pattern = "*/nvim/lua/plugins.lua",
  group = api.nvim_create_augroup("packer_auto_compile", { clear = true }),
  callback = function(ctx)
    local cmd = "source " .. ctx.file
    vim.cmd(cmd)
    vim.cmd("PackerCompile")
    vim.notify("PackerCompile done!", vim.log.levels.INFO, { title = "Nvim-config" })
  end,
})


