return {
    "akinsho/bufferline.nvim",
    event = {"BufReadPost", "BufNewFile"},
    opts = {
        options = {
            always_show_bufferline = true,
            show_buffer_close_icons = false,
            enforce_regular_tabs = true,
            separator_style = "slant", -- | "thick" | "thin" | { 'any', 'any' },
            indicator = {
                style = "none"
            },
            modified_icon = "",
            close_command = "Bdelete! %d", -- can be a string | function, see "Mouse actions"
            offsets = {{
                filetype = "neo-tree",
                text_align = "center"
                -- separator = true,
            }}
        }
    }
}
