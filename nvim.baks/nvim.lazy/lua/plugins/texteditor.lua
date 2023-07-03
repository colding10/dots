return {
	{ "jdhao/whitespace.nvim", event = "VimEnter" },
	{ "machakann/vim-sandwich", event = "VimEnter" },
	{ "tpope/vim-commentary", event = "VimEnter" },
	{ "itchyny/vim-highlighturl", event = "VimEnter" },
	{
		"lukas-reineke/indent-blankline.nvim",
		event = "VimEnter",
		config = function()
			local api = vim.api

local exclude_ft = { "help", "git", "markdown", "snippets", "text", "gitconfig", "alpha" }
require("indent_blankline").setup({
	-- U+2502 may also be a good choice, it will be on the middle of cursor.
	-- U+250A is also a good choice
	char = "▏",
	show_end_of_line = false,
	disable_with_nolist = true,
	buftype_exclude = { "terminal" },
	filetype_exclude = exclude_ft,
})

local gid = api.nvim_create_augroup("indent_blankline", { clear = true })
api.nvim_create_autocmd("InsertEnter", {
	pattern = "*",
	group = gid,
	command = "IndentBlanklineDisable",
})

api.nvim_create_autocmd("InsertLeave", {
	pattern = "*",
	group = gid,
	callback = function()
		if not vim.tbl_contains(exclude_ft, vim.bo.filetype) then
			vim.cmd([[IndentBlanklineEnable]])
		end
	end,
})

		end
	},
	{ "michaeljsmith/vim-indent-object", event = "VimEnter" },
	{
		"phaazon/hop.nvim",
		event = "VimEnter",
		-- config = function()
		-- 	vim.defer_fn(function()
		-- 		require("config.nvim_hop")
		-- 	end, 2000)
		-- end,
	},
	{ "Raimondi/delimitMate", event = "InsertEnter" },
	{ "wellle/targets.vim", event = "VimEnter" },
	-- Additional powerful text object for vim, this plugin should be studied
	-- carefully to use its full power
}
