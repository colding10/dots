local config = require("config.lualine.config").options
local icons = require("core.icons")

local M = {}

local hl_str = function(str, hl_cur, hl_after)
    if hl_after == nil then
        return "%#" .. hl_cur .. "#" .. str .. "%*"
    end
    return "%#" .. hl_cur .. "#" .. str .. "%*" .. "%#" .. hl_after .. "#"
end

local function hide_in_width()
    return vim.fn.winwidth(0) > 85
end

-- M.mode = {
--     "mode",
--     fmt = function(str)
--         local left_sep = hl_str(config.separator_icon.left, "SLSeparator", "SLPadding")
--         local right_sep = hl_str(config.separator_icon.right, "SLSeparator", "SLPadding")
--         return left_sep .. hl_str(str, "SLMode") .. right_sep
--     end
-- }

M.mode = function()
    mode_names = { -- change the strings if you like it vvvvverbose!
        n = "N",
        no = "N?",
        nov = "N?",
        noV = "N?",
        ["no\22"] = "N?",
        niI = "Ni",
        niR = "Nr",
        niV = "Nv",
        nt = "Nt",
        v = "V",
        vs = "Vs",
        V = "V_",
        Vs = "Vs",
        ["\22"] = "^V",
        ["\22s"] = "^V",
        s = "S",
        S = "S_",
        ["\19"] = "^S",
        i = "I",
        ic = "Ic",
        ix = "Ix",
        R = "R",
        Rc = "Rc",
        Rx = "Rx",
        Rv = "Rv",
        Rvc = "Rv",
        Rvx = "Rv",
        c = "C",
        cv = "Ex",
        r = "...",
        rm = "M",
        ["r?"] = "?",
        ["!"] = "!",
        t = "T"
    }
    mode_colors = {
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

    local left_sep = hl_str(config.separator_icon.left, "SLSeparator")
    local right_sep = hl_str(config.separator_icon.right, "SLSeparator", "SLSeparator")

    local mode = vim.fn.mode(1):sub(1, 1) -- get only the first mode character
    local hlcolor = mode_colors[mode]

    local name = mode_names[vim.fn.mode(1)]

    return left_sep .. " %2(" .. hl_str(name, hlcolor) .. "%)" .. right_sep
end

M.filename = function()
    local filename = vim.api.nvim_buf_get_name(0)
    local filename_file = vim.fn.fnamemodify(filename, ":.")
    local extension = vim.fn.fnamemodify(filename, ":e")
    local icon, icon_color = require("nvim-web-devicons").get_icon_color(filename, extension, {
        default = true
    })

    local function getFlags()
        local out = ""
        if (vim.bo.modified) then
            out = out .. "[+]"
        end
        if (not vim.bo.modifiable or vim.bo.readonly) then
            out = out .. ""
        end

        return out
    end

    local left_sep = hl_str(config.separator_icon.left, "SLSeparator")
    local right_sep = hl_str(config.separator_icon.right, "SLSeparator", "SLSeparator")
    return left_sep .. icon .. " " .. filename_file .. getFlags() .. right_sep
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

    local left_sep = hl_str(config.thin_separator_icon.left, "SLSeparator")
    local right_sep = hl_str(config.thin_separator_icon.right, "SLSeparator", "SLSeparator")

    if (error_count > 0) then
        out = out .. hl_str(icons.diagnostics.error .. " " .. error_count, "SLError", "SLError")
    end
    if (warn_count > 0) then
        out = out .. hl_str(icons.diagnostics.warn .. " " .. warn_count, "SLWarning", "SLWarning")
    end
    if (hint_count > 0) then
        out = out .. hl_str(icons.diagnostics.hint .. " " .. hint_count, "SLInfo", "SLInfo")
    end
    -- local info_hl = hl_str(icons.diagnostics.info .. " " .. info_count, "SLInfo", "SLInfo")

    return left_sep .. out .. right_sep
end

M.position = function()
    -- print(vim.inspect(config.separator_icon))
    local current_line = vim.fn.line(".")
    local current_column = vim.fn.col(".")
    local total_line = vim.fn.line('$')
    
    local left_sep = hl_str(config.separator_icon.left, "SLSeparator")
    local right_sep = hl_str(config.separator_icon.right, "SLSeparator", "SLSeparator")
    local str = current_line .. "/" .. total_line .. ": " .. current_column

    return left_sep .. hl_str(str, "SLPosition", "SLPosition") .. right_sep
end

M.scrollbar = function()
    local sbar = {'▁', '▂', '▃', '▄', '▅', '▆', '▇', '█'}
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
        local left_sep = hl_str(config.separator_icon.left, "SLSeparator")
        local right_sep = hl_str(config.separator_icon.right, "SLSeparator", "SLSeparator")
        -- Upper case first character
        filetype_str = filetype_str:gsub("%a", string.upper, 1)
        local filetype_hl = hl_str(filetype_str:upper(), "SLFiletype", "SLFiletype")
        return left_sep .. filetype_hl .. right_sep
    end
}

return M
