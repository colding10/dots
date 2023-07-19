local M = {}
local fn = vim.fn

M.git_colors = {
    GitAdd = "#A1C281",
    GitChange = "#74ADEA",
    GitDelete = "#FE747A"
}
M.lsp_signs = {
    Error = "✖ ",
    Warn = "! ",
    Hint = "󰌶 ",
    Info = " "
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
    Null = " "
}

M.mason_packages = {"black", "clang-format", "clangd", "codelldb", "json-lsp", "lua-language-server", "markdownlint",
                    "prettier", "pyright"}

M.lsp_servers = {"clangd", "pyright", "lua_ls"}

function M.on_attach(on_attach)
    vim.api.nvim_create_autocmd("LspAttach", {
        callback = function(args)
            local buffer = args.buf
            local client = vim.lsp.get_client_by_id(args.data.client_id)
            on_attach(client, buffer)
        end
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
        return require("util").info("Set " .. option .. " to " .. vim.opt_local[option]:get(), {
            title = "Option"
        })
    end
    vim.opt_local[option] = not vim.opt_local[option]:get()
    if not silent then
        if vim.opt_local[option]:get() then
            require("util").info("Enabled " .. option, {
                title = "Option"
            })
        else
            require("util").warn("Disabled " .. option, {
                title = "Option"
            })
        end
    end
end

M.diagnostics_active = true
function M.toggle_diagnostics()
    M.diagnostics_active = not M.diagnostics_active
    if M.diagnostics_active then
        vim.diagnostic.show()
        require("util").info("Enabled Diagnostics", {
            title = "Lsp"
        })
    else
        vim.diagnostic.hide()
        require("util").warn("Disabled Diagnostics", {
            title = "Lsp"
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

M.root_patterns = {".git", "lua", "package.json", "mvnw", "gradlew", "pom.xml", "build.gradle", "release", ".project"}

M.augroup = function(name)
    return vim.api.nvim_create_augroup("colding10_" .. name, {
        clear = true
    })
end

M.has = function(plugin)
    return require("lazy.core.config").plugins[plugin] ~= nil
end

M.get_highlight_value = function(group)
    local found, hl = pcall(vim.api.nvim_get_hl_by_name, group, true)
    if not found then
        return {}
    end
    local hl_config = {}
    for key, value in pairs(hl) do
        _, hl_config[key] = pcall(string.format, "#%02x", value)
    end
    return hl_config
end

M.get_root = function()
    ---@type string?
    local path = vim.api.nvim_buf_get_name(0)
    path = path ~= "" and vim.loop.fs_realpath(path) or nil
    ---@type string[]
    local roots = {}
    if path then
        for _, client in pairs(vim.lsp.get_active_clients({
            bufnr = 0
        })) do
            local workspace = client.config.workspace_folders
            local paths = workspace and vim.tbl_map(function(ws)
                return vim.uri_to_fname(ws.uri)
            end, workspace) or client.config.root_dir and {client.config.root_dir} or {}
            for _, p in ipairs(paths) do
                local r = vim.loop.fs_realpath(p)
                if path:find(r, 1, true) then
                    roots[#roots + 1] = r
                end
            end
        end
    end
    table.sort(roots, function(a, b)
        return #a > #b
    end)
    ---@type string?
    local root = roots[1]
    if not root then
        path = path and vim.fs.dirname(path) or vim.loop.cwd()
        ---@type string?
        root = vim.fs.find(M.root_patterns, {
            path = path,
            upward = true
        })[1]
        root = root and vim.fs.dirname(root) or vim.loop.cwd()
    end
    ---@cast root string
    return root
end

M.set_root = function(dir)
    vim.api.nvim_set_current_dir(dir)
end

---@param type "ivy" | "dropdown" | "cursor" | nil
M.telescope = function(builtin, type, opts)
    local params = {
        builtin = builtin,
        type = type,
        opts = opts
    }
    return function()
        builtin = params.builtin
        type = params.type
        opts = params.opts
        opts = vim.tbl_deep_extend("force", {
            cwd = M.get_root()
        }, opts or {})
        local theme
        if vim.tbl_contains({"ivy", "dropdown", "cursor"}, type) then
            theme = M.telescope_theme(type)
        else
            theme = opts
        end
        require("telescope.builtin")[builtin](theme)
    end
end

---@param name "autocmds" | "options" | "keymaps"
M.load = function(name)
    local Util = require("lazy.core.util")
    -- always load lazyvim, then user file
    local mod = "core." .. name
    Util.try(function()
        require(mod)
    end, {
        msg = "Failed loading " .. mod,
        on_error = function(msg)
            local modpath = require("lazy.core.cache").find(mod)
            if modpath then
                Util.error(msg)
            end
        end
    })
end

M.on_very_lazy = function(fn)
    vim.api.nvim_create_autocmd("User", {
        pattern = "VeryLazy",
        callback = function()
            fn()
        end
    })
end

M.notify = function(msg, level, opts)
    opts = opts or {}
    level = vim.log.levels[level:upper()]
    if type(msg) == "table" then
        msg = table.concat(msg, "\n")
    end
    local nopts = {
        title = "Nvim"
    }
    if opts.once then
        return vim.schedule(function()
            vim.notify_once(msg, level, nopts)
        end)
    end
    vim.schedule(function()
        vim.notify(msg, level, nopts)
    end)
end

return M
