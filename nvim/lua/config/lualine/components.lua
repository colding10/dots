local icons = require("core.icons")

local M = {}


M.mode = function()
    local mode_names = { -- change the strings if you like it vvvvverbose!
        n = "NORMAL",
        no = "NORMAL?",
        nov = "NORMAL?",
        noV = "NORMAL?",
        ["no\22"] = "NORMAL?",
        niI = "NORMALi",
        niR = "NORMALr",
        niV = "NORMALv",
        nt = "NORMALt",
        v = "VISUAL",
        vs = "VISUALs",
        V = "V-LINE",
        Vs = "VISUALs",
        ["\22"] = "^VISUAL",
        ["\22s"] = "^VISUAL",
        s = "S",
        S = "S_",
        ["\19"] = "^S",
        i = "INSERT",
        ic = "INSERTc",
        ix = "INSERTx",
        R = "REPLACE",
        Rc = "REPLACEc",
        Rx = "REPLACEx",
        Rv = "REPLACEv",
        Rvc = "REPLACEv",
        Rvx = "REPLACEv",
        c = "COMMAND",
        cv = "Ex",
        r = "...",
        rm = "M",
        ["r?"] = "?",
        ["!"] = "!",
        t = "TERMINAL"
    }
    local mode_colors = {
        n = "red",
        i = "green",
        v = "cyan",
        V = "cyan",
        ["\22"] = "cyan",
        c = "orange",
        s = "purple",
        S = "purple",
        ["\19"] = "purple",
        R = "orange",
        r = "orange",
        ["!"] = "red",
        t = "red"
    }

    local mode = vim.fn.mode(1):sub(1, 1) -- get only the first mode character
    local hlcolor = mode_colors[mode]

    local name = mode_names[vim.fn.mode(1)]

    return " %2(" .. name .. "%)"
end

M.path = function()
    local dir = vim.fn.getcwd()
    local icon = require('core.icons').kinds.Folder

    return icon .. " " .. dir
end

M.filename = function()
    local filename = vim.api.nvim_buf_get_name(0)

    local extension = vim.fn.fnamemodify(filename, ":e")
    local icon, icon_color = require("nvim-web-devicons").get_icon_color(filename, extension, {
        default = true
    })

    return icon .. " " .. vim.fn.expand('%:h') 
end

M.diagnostics = function()
    local function nvim_diagnostic()
        local diagnostics = vim.diagnostic.get(0)
        local count = {0, 0, 0, 0}
        for _, diagnostic in ipairs(diagnostics) do
            count[diagnostic.severity] = count[diagnostic.severity] + 1
        end
        return count[vim.diagnostic.severity.ERROR], count[vim.diagnostic.severity.WARN],
            count[vim.diagnostic.severity.INFO], count[vim.diagnostic.severity.HINT]
    end

    local error_count, warn_count, info_count, hint_count = nvim_diagnostic()
    local out = ""

    if (error_count > 0) then
        out = out .. icons.diagnostics.error .. " " .. error_count, "SLError", "SLError"
    end
    if (warn_count > 0) then
        out = out .. icons.diagnostics.warn .. " " .. warn_count, "SLWarning", "SLWarning"
    end
    if (hint_count > 0) then
        out = out .. icons.diagnostics.hint .. " " .. hint_count, "SLInfo", "SLInfo"
    end
    -- local info_hl = hl_str(icons.diagnostics.info .. " " .. info_count, "SLInfo", "SLInfo")

    return out
end

M.position = function()
    -- print(vim.inspect(config.separator_icon))
    local current_line = vim.fn.line(".")
    local current_column = vim.fn.col(".")
    local total_line = vim.fn.line('$')

    local str = current_line .. "/" .. total_line .. ": " .. current_column

    return str
end

M.keymap = function()
    if vim.opt.iminsert:get() > 0 and vim.b.keymap_name then
        return '⌨ ' .. vim.b.keymap_name
    end
    return ''
end

M.scrollbar = function()
    local sbar = {"▁","▂","▃","▄","▅","▆","▇","█"}

    local curr_line = vim.api.nvim_win_get_cursor(0)[1]
    local lines = vim.api.nvim_buf_line_count(0)
    local i = math.floor((curr_line - 1) / lines * #sbar) + 1
    return string.rep(sbar[i], 2)
end

M.lsp = function()
    local names = {}
    for i, server in pairs(vim.lsp.get_active_clients({
        bufnr = 0
    })) do
        table.insert(names, server.name)
    end
    return " [" .. table.concat(names, " ") .. "]"

end

local prev_filetype = ""
M.filetype = {
    "filetype",
    icons_enabled = false,
    icons_only = false,
    fmt = function(str)
        local ui_filetypes = {"help", "packer", "neogitstatus", "NvimTree", "Trouble", "lir", "Outline",
                              "spectre_panel", "toggleterm", "DressingSelect", "neo-tree", ""}
        local filetype_str = ""

        if str == "toggleterm" then
            -- 
            filetype_str = "ToggleTerm " .. vim.api.nvim_buf_get_var(0, "toggle_number")
        elseif str == "TelescopePrompt" then
            filetype_str = ""
        elseif str == "neo-tree" or str == "neo-tree-popup" then
            if prev_filetype == "" then
                return
            end
            filetype_str = prev_filetype
        elseif str == "help" then
            filetype_str = ""
        elseif vim.tbl_contains(ui_filetypes, str) then
            return
        else
            prev_filetype = str
            filetype_str = str
        end

        -- Upper case first character
        filetype_str = filetype_str:gsub("%a", string.upper, 1)

        return filetype_str:upper()
    end
}

return M
