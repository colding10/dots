local config = require("config.lualine.config")

local M = {}

local function setup()
    local cpn = require("config.lualine.components")
    local theme = require("config.lualine.highlights").custom(config.options)

    require("lualine").setup({
        options = {
            theme = "palenight", -- theme,
            icons_enabled = true,
            component_separators = {
                left = "",
                right = ""
            },
            section_separators = {
                left = "",
                right = ""
            },
            disabled_filetypes = {
                statusline = {"dashboard", "lazy", "alpha"}
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
            lualine_a = {cpn.mode},
            lualine_b = {cpn.filename},
            lualine_c = {},
            lualine_x = {cpn.diagnostics, cpn.lsp},
            lualine_y = {cpn.filetype},
            lualine_z = {cpn.position, cpn.scrollbar}
        },
        tabline = {},
        extensions = {}
    })
end

M.setup = config.setup

M.load = function()
    setup()
    vim.api.nvim_create_autocmd("ColorScheme", {
        callback = function()
            setup()
        end
    })
end

return M
