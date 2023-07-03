return {
	{ "folke/zen-mode.nvim", cmd = "ZenMode" },
	{ "stevearc/dressing.nvim" },
	{ "mrjones2014/nvim-ts-rainbow" },

	{
		"kevinhwang91/nvim-bqf",
		ft = "qf",
		config = function()
			require("bqf").setup({
				auto_resize_height = false,
				preview = {
					auto_preview = false,
				},
			})
		end,
	},
	{
		"akinsho/bufferline.nvim",
		event = "VimEnter",
		config = function()
			require("bufferline").setup({
				options = {
					numbers = "buffer_id",
					close_command = "bdelete! %d",
					right_mouse_command = nil,
					left_mouse_command = "buffer %d",
					middle_mouse_command = nil,
					indicator = {
						icon = "▎", -- this should be omitted if indicator style is not 'icon'
						style = "icon",
					},
					buffer_close_icon = "",
					modified_icon = "●",
					close_icon = "",
					left_trunc_marker = "",
					right_trunc_marker = "",
					max_name_length = 18,
					max_prefix_length = 15,
					tab_size = 10,
					diagnostics = false,
					custom_filter = function(bufnr)
						-- if the result is false, this buffer will be shown, otherwise, this
						-- buffer will be hidden.

						-- filter out filetypes you don't want to see
						local exclude_ft = { "qf", "fugitive", "git" }
						local cur_ft = vim.bo[bufnr].filetype
						local should_filter = vim.tbl_contains(exclude_ft, cur_ft)

						if should_filter then
							return false
						end

						return true
					end,
					show_buffer_icons = false,
					show_buffer_close_icons = true,
					show_close_icon = true,
					show_tab_indicators = true,
					persist_buffer_sort = true, -- whether or not custom sorted buffers should persist
					separator_style = "bar",
					enforce_regular_tabs = false,
					always_show_bufferline = true,
					sort_by = "id",
				},
			})
		end,
	},
	{
		"nvim-lualine/lualine.nvim",
		event = "VimEnter",
		config = function()
			local fn = vim.fn

			local function spell()
				if vim.o.spell then
					return string.format("[SPELL]")
				end

				return ""
			end

			--- show indicator for Chinese IME
			local function ime_state()
				if vim.g.is_mac then
					-- ref: https://github.com/vim-airline/vim-airline/blob/master/autoload/airline/extensions/xkblayout.vim#L11
					local layout = fn.libcall(vim.g.XkbSwitchLib, "Xkb_Switch_getXkbLayout", "")

					-- We can use `xkbswitch -g` on the command line to get current mode.
					-- mode for macOS builtin pinyin IME: com.apple.inputmethod.SCIM.ITABC
					-- mode for Rime: im.rime.inputmethod.Squirrel.Rime
					local res = fn.match(layout, [[\v(Squirrel\.Rime|SCIM.ITABC)]])
					if res ~= -1 then
						return "[CN]"
					end
				end

				return ""
			end

			local function trailing_space()
				if not vim.o.modifiable then
					return ""
				end

				local line_num = nil

				for i = 1, fn.line("$") do
					local linetext = fn.getline(i)
					-- To prevent invalid escape error, we wrap the regex string with `[[]]`.
					local idx = fn.match(linetext, [[\v\s+$]])

					if idx ~= -1 then
						line_num = i
						break
					end
				end

				local msg = ""
				if line_num ~= nil then
					msg = string.format("[%d]trailing", line_num)
				end

				return msg
			end

			local function mixed_indent()
				if not vim.o.modifiable then
					return ""
				end

				local space_pat = [[\v^ +]]
				local tab_pat = [[\v^\t+]]
				local space_indent = fn.search(space_pat, "nwc")
				local tab_indent = fn.search(tab_pat, "nwc")
				local mixed = (space_indent > 0 and tab_indent > 0)
				local mixed_same_line
				if not mixed then
					mixed_same_line = fn.search([[\v^(\t+ | +\t)]], "nwc")
					mixed = mixed_same_line > 0
				end
				if not mixed then
					return ""
				end
				if mixed_same_line ~= nil and mixed_same_line > 0 then
					return "MI:" .. mixed_same_line
				end
				local space_indent_cnt = fn.searchcount({ pattern = space_pat, max_count = 1e3 }).total
				local tab_indent_cnt = fn.searchcount({ pattern = tab_pat, max_count = 1e3 }).total
				if space_indent_cnt > tab_indent_cnt then
					return "MI:" .. tab_indent
				else
					return "MI:" .. space_indent
				end
			end

			local diff = function()
				local git_status = vim.b.gitsigns_status_dict
				if git_status == nil then
					return
				end

				local modify_num = git_status.changed
				local remove_num = git_status.removed
				local add_num = git_status.added

				local info = { added = add_num, modified = modify_num, removed = remove_num }
				-- vim.print(info)
				return info
			end

			require("lualine").setup({
				options = {
					icons_enabled = true,
					theme = "auto",
					-- component_separators = { left = "", right = "" },
					-- section_separators = { left = "", right = "" },
					section_separators = "",
					component_separators = "",
					disabled_filetypes = {},
					always_divide_middle = true,
				},
				sections = {
					lualine_a = { "mode" },
					lualine_b = {
						"branch",
						{
							"diff",
							source = diff,
						},
					},
					lualine_c = {
						"filename",
						{
							ime_state,
							color = { fg = "black", bg = "#f46868" },
						},
						{
							spell,
							color = { fg = "black", bg = "#a7c080" },
						},
					},
					lualine_x = {
						"encoding",
						{
							"fileformat",
							symbols = {
								unix = "unix",
								dos = "win",
								mac = "mac",
							},
						},
						"filetype",
					},
					lualine_y = { "progress" },
					lualine_z = {
						"location",
						{
							"diagnostics",
							sources = { "nvim_diagnostic" },
						},
						{
							trailing_space,
							color = "WarningMsg",
						},
						{
							mixed_indent,
							color = "WarningMsg",
						},
					},
				},
				inactive_sections = {
					lualine_a = {},
					lualine_b = {},
					lualine_c = { "filename" },
					lualine_x = { "location" },
					lualine_y = {},
					lualine_z = {},
				},
				tabline = {},
				extensions = { "quickfix", "fugitive", "nvim-tree" },
			})
		end,
	},
	-- 		local function footer_info()
	-- 			local total_plugins = #vim.tbl_keys(packer_plugins)
	-- 			local datetime = os.date(" %d-%m-%Y   %H:%M:%S")
	-- 			local version = vim.version()
	-- 			local nvim_version_info = "   v" .. version.major .. "." .. version.minor .. "." .. version.patch

	-- 			return datetime .. "   " .. total_plugins .. " plugins" .. nvim_version_info
	-- 		end
	{
		"goolord/alpha-nvim",
		event = "VimEnter",
		opts = function()
			local dashboard = require("alpha.themes.dashboard")
			local logo = [[
███╗   ██╗███████╗ ██████╗ ██╗   ██╗██╗███╗   ███╗ 
████╗  ██║██╔════╝██╔═══██╗██║   ██║██║████╗ ████║ 
██╔██╗ ██║█████╗  ██║   ██║██║   ██║██║██╔████╔██║ 
██║╚██╗██║██╔══╝  ██║   ██║╚██╗ ██╔╝██║██║╚██╔╝██║ 
██║ ╚████║███████╗╚██████╔╝ ╚████╔╝ ██║██║ ╚═╝ ██║ 
╚═╝  ╚═══╝╚══════╝ ╚═════╝   ╚═══╝  ╚═╝╚═╝     ╚═╝ 
    		]]

			dashboard.section.header.val = vim.split(logo, "\n")
			dashboard.section.buttons.val = {
				dashboard.button("e", "  > New file", ":ene <BAR> startinsert <CR>"),
				dashboard.button("f", "  > Find file", ":cd $HOME | Telescope find_files<CR>"),
				dashboard.button("F", "  > Find text", ":cd $HOME | Telescope live_grep<CR>"),
				dashboard.button("m", "  > Find marks", ":cd $HOME | Telescope marks<CR>"),
				dashboard.button("r", "  > Recent", ":Telescope oldfiles<CR>"),
				dashboard.button("s", "  > Restore session", [[:lua require("persistence").load() <cr>]]),
				-- dashboard.button("p", "  > Update", ":PackerSync<CR>"),
				dashboard.button("s", "  > Settings", ":e $MYVIMRC | :cd %:p:h | split . | wincmd k | pwd<CR>"),
				dashboard.button("q", "  > Quit NVIM", ":qa<CR>"),
			}

			for _, button in ipairs(dashboard.section.buttons.val) do
				button.opts.hl = "AlphaButtons"
				button.opts.hl_shortcut = "AlphaShortcut"
			end

			dashboard.section.header.opts.hl = "AlphaHeader"
			dashboard.section.buttons.opts.hl = "AlphaButtons"
			dashboard.section.footer.opts.hl = "AlphaFooter"
			dashboard.opts.layout[1].val = 8
			return dashboard
		end,

		config = function(_, dashboard)
			-- close Lazy and re-open when the dashboard is ready
			if vim.o.filetype == "lazy" then
				vim.cmd.close()
				vim.api.nvim_create_autocmd("User", {
					pattern = "AlphaReady",
					callback = function()
						require("lazy").show()
					end,
				})
			end

			require("alpha").setup(dashboard.opts)

			vim.api.nvim_create_autocmd("User", {
				pattern = "LazyVimStarted",
				callback = function()
					local stats = require("lazy").stats()
					local ms = (math.floor(stats.startuptime * 100 + 0.5) / 100)
					dashboard.section.footer.val = "⚡ Neovim loaded " .. stats.count .. " plugins in " .. ms .. "ms"
					pcall(vim.cmd.AlphaRedraw)
				end,
			})
		end,
	},
}
