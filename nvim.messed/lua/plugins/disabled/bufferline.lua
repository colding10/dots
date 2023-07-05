return {
    "akinsho/bufferline.nvim",
    event = {"BufReadPost", "BufNewFile"},
    opts = {
        options = {
            diagnostics = "nvim_lsp", -- | "nvim_lsp" | "coc",
            -- separator_style = "", -- | "thick" | "thin" | "slope" | { 'any', 'any' },
            -- separator_style = { "", "" }, -- | "thick" | "thin" | { 'any', 'any' },
            separator_style = "slant", -- | "thick" | "thin" | { 'any', 'any' },
            indicator = {
                -- icon = " ",
                -- style = 'icon',
                style = "bold"
            },
            close_command = "Bdelete! %d", -- can be a string | function, see "Mouse actions"
            diagnostics_indicator = function(count, _, _, _)
                if count > 9 then
                    return "9+"
                end
                return tostring(count)
            end,
            offsets = {{
                filetype = "neo-tree",
                text = "EXPLORER",
                text_align = "center"
                -- separator = true,
            }},
            hover = {
                enabled = true,
                delay = 0,
                reveal = {"close"}
            }
        }
    }
}
