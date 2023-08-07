return {
    "nvim-lualine/lualine.nvim",
    event = "VeryLazy",
    opts = {},
    config = function()
        local function CPN_lsp()
            local names = {}
            for i, server in pairs(vim.lsp.get_active_clients({
                bufnr = 0
            })) do
                table.insert(names, server.name)
            end
            return " [" .. table.concat(names, " ") .. "]"
        end

        local function CPN_pos()
            -- print(vim.inspect(config.separator_icon))
            local current_line = vim.fn.line(".")
            local current_column = vim.fn.col(".")
            local total_line = vim.fn.line('$')

            local str = current_line .. "/" .. total_line .. ": " .. current_column

            return str
        end

        local CPN_filetype = {
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

        local function setup()
            require("lualine").setup({
                options = {
                    theme = require("onedarkpro").theme,
                    icons_enabled = true,
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
                    lualine_a = {{
                        "mode",
                        separator = {
                            left = ''
                        },
                        right_padding = 2
                    }},
                    lualine_b = {{
                        "filename",
                        file_status = true,
                        path = 3
                    }},
                    lualine_c = {{
                        "diagnostics",
                        symbols = {
                            error = " ",
                            warn = " ",
                            hint = " ",
                            info = " "
                        }
                    }},
                    lualine_x = {CPN_lsp},
                    lualine_y = {CPN_filetype},
                    lualine_z = {{
                        CPN_pos,
                        separator = {
                            right = ''
                        },
                        left_padding = 2
                    }}
                },
                tabline = {},
                extensions = {}
            })
        end

        local function load()
            setup()
            vim.api.nvim_create_autocmd("ColorScheme", {
                callback = function()
                    setup()
                end
            })
        end

        load()
    end
}
