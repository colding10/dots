local M = {}

local function setup()
    local cpn = require("config.lualine.components")

    require("lualine").setup({
        options = {
            theme = require("onedarkpro").theme,
            icons_enabled = false,
            component_separators = '|',
            section_separators = {
                left = '',
                right = ''
            },
            disabled_filetypes = {
                statusline = {"dashboard", "lazy", "alpha", "mason"}
            },
            ignore_focus = {},
            always_divide_middle = true,
            globalstatus = true,
            refresh = {
                statusline = 1000,
                tabline = 1000
                -- winbar = 100,
            }
        },
        sections = {
            lualine_a = {{"mode", separator = { left = '' }, right_padding = 2}},
            lualine_b = {{
                "filename",
                file_status = true,
                path = 3
            }},
            lualine_c = {{
                "diagnostics",
                symbols = require("core.icons").diagnostics
            }},
            lualine_x = {cpn.lsp},
            lualine_y = {cpn.filetype},
            lualine_z = {{cpn.position, separator = { right = '' }, left_padding = 2 }}
        },
        tabline = {},
        extensions = {}
    })
end

M.setup = function()
end

M.load = function()
    setup()
    vim.api.nvim_create_autocmd("ColorScheme", {
        callback = function()
            setup()
        end
    })
end

return M
