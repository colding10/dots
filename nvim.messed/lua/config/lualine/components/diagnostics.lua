return function()
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