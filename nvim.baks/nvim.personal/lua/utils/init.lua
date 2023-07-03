local M = {}
local fn = vim.fn

M.git_colors = {
	GitAdd = "#A1C281",
	GitChange = "#74ADEA",
	GitDelete = "#FE747A",
}
M.lsp_signs = {
	Error = "✖ ",
	Warn = "! ",
	Hint = "󰌶 ",
	Info = " ",
}

M.lsp_kinds = {
	Text = " ",
	Method = " ",
	Function = " ",
	Constructor = " ",
	Field = " ",
	Variable = " ",
	Class = " ",
	Interface = " ",
	Module = " ",
	Property = " ",
	Unit = " ",
	Value = " ",
	Enum = " ",
	Keyword = " ",
	Snippet = " ",
	Color = " ",
	File = " ",
	Reference = " ",
	Folder = " ",
	EnumMember = " ",
	Constant = " ",
	Struct = " ",
	Event = " ",
	Operator = " ",
	TypeParameter = " ",
	Copilot = " ",
	Namespace = " ",
	Package = " ",
	String = " ",
	Number = " ",
	Boolean = " ",
	Array = " ",
	Object = " ",
	Key = " ",
	Null = " ",
}

M.mason_packages = {
	"bash-language-server",
	"black",
	"clang-format",
	"clangd",
	"codelldb",
	"cspell",
	"css-lsp",
	"eslint-lsp",
	"graphql-language-service-cli",
	"html-lsp",
	"json-lsp",
	"lua-language-server",
	"markdownlint",
	"prettier",
	"pyright",
	"shfmt",
	"tailwindcss-language-server",
	"taplo",
	"typescript-language-server",
	"yaml-language-server",
	"gopls",
	"editorconfig-checker",
}

M.lsp_servers = {
	"clangd",
	"tsserver",
	"pyright",
	"lua_ls",
	"eslint",
	"bashls",
	"yamlls",
	"jsonls",
	"cssls",
	"taplo",
	"html",
	"graphql",
	"tailwindcss",
	"gopls",
}

function M.on_attach(on_attach)
	vim.api.nvim_create_autocmd("LspAttach", {
		callback = function(args)
			local buffer = args.buf
			local client = vim.lsp.get_client_by_id(args.data.client_id)
			on_attach(client, buffer)
		end,
	})
end

function M.warn(msg, notify_opts)
	vim.notify(msg, vim.log.levels.WARN, notify_opts)
end

function M.error(msg, notify_opts)
	vim.notify(msg, vim.log.levels.ERROR, notify_opts)
end

function M.info(msg, notify_opts)
	vim.notify(msg, vim.log.levels.INFO, notify_opts)
end

---@param silent boolean?
---@param values? {[1]:any, [2]:any}
function M.toggle(option, silent, values)
	if values then
		if vim.opt_local[option]:get() == values[1] then
			vim.opt_local[option] = values[2]
		else
			vim.opt_local[option] = values[1]
		end
		return require("utils").info("Set " .. option .. " to " .. vim.opt_local[option]:get(), {
			title = "Option",
		})
	end
	vim.opt_local[option] = not vim.opt_local[option]:get()
	if not silent then
		if vim.opt_local[option]:get() then
			require("utils").info("Enabled " .. option, {
				title = "Option",
			})
		else
			require("utils").warn("Disabled " .. option, {
				title = "Option",
			})
		end
	end
end

M.diagnostics_active = true
function M.toggle_diagnostics()
	M.diagnostics_active = not M.diagnostics_active
	if M.diagnostics_active then
		vim.diagnostic.show()
		require("utils").info("Enabled Diagnostics", {
			title = "Lsp",
		})
	else
		vim.diagnostic.hide()
		require("utils").warn("Disabled Diagnostics", {
			title = "Lsp",
		})
	end
end

M.quickfix_active = false
function M.toggle_quickfix()
	M.quickfix_active = not M.quickfix_active
	if M.quickfix_active then
		vim.diagnostic.setloclist()
	else
		vim.cmd([[ lclose ]])
	end
end

function M.executable(name)
	if fn.executable(name) > 0 then
		return true
	end

	return false
end

--- check whether a feature exists in Nvim
--- @feat: string
---   the feature name, like `nvim-0.7` or `unix`.
--- return: bool
M.has = function(feat)
	if fn.has(feat) == 1 then
		return true
	end

	return false
end

--- Create a dir if it does not exist
function M.may_create_dir(dir)
	local res = fn.isdirectory(dir)

	if res == 0 then
		fn.mkdir(dir, "p")
	end
end

--- Generate random integers in the range [Low, High], inclusive,
--- adapted from https://stackoverflow.com/a/12739441/6064933
--- @low: the lower value for this range
--- @high: the upper value for this range
function M.rand_int(low, high)
	-- Use lua to generate random int, see also: https://stackoverflow.com/a/20157671/6064933
	math.randomseed(os.time())

	return math.random(low, high)
end

--- Select a random element from a sequence/list.
--- @seq: the sequence to choose an element
function M.rand_element(seq)
	local idx = M.rand_int(1, #seq)

	return seq[idx]
end

function M.add_pack(name)
	local status, error = pcall(vim.cmd, "packadd " .. name)

	return status
end

return M
