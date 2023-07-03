return {
    "chentoast/marks.nvim",
    event = "BufReadPre",
    config = function()
        require("marks").setup({
            default_mappings = true,
            -- which builtin marks to show. default {}
            builtin_marks = { ".", "<", ">", "^" },
            cyclic = true,
            -- whether the shada file is updated after modifying uppercase marks. default false
            force_write_shada = false,
            refresh_interval = 250,
            sign_priority = {
                lower = 10,
                upper = 15,
                builtin = 8,
                bookmark = 20,
            },
            excluded_filetypes = {},
            mappings = {},
        })
    end,
}
