return {
    "akinsho/toggleterm.nvim",
    event = {"BufReadPost", "BufNewFile"},
    opts = {
        open_mapping = [[<C-\>]],
        start_in_insert = true,
        direction = "float",
        autochdir = true,
        highlights = {
            FloatBorder = {
                link = "ToggleTermBorder"
            },
            Normal = {
                link = "ToggleTerm"
            },
            NormalFloat = {
                link = "ToggleTerm"
            }
        },
        winbar = {
            enabled = true,
            name_formatter = function(term)
                return string.format("%d:%s", term.id, term:_display_name())
            end
        }
    }
}
