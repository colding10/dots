return {
    "lukas-reineke/indent-blankline.nvim",
    event = {"BufReadPost", "BufNewFile"},
    opts = {
        char = "▏",
        context_char = "▏",
        show_end_of_line = false,
        space_char_blankline = " ",
        show_current_context = false,
        show_current_context_start = false,
        filetype_exclude = {"help", "startify", "dashboard", "packer", "neogitstatus", "NvimTree", "Trouble", "alpha",
                            "neo-tree"},
        buftype_exclude = {"terminal", "nofile"}
        -- char_highlight_list = {
        --   "IndentBlanklineIndent1",
        --   "IndentBlanklineIndent2",
        --   "IndentBlanklineIndent3",
        --   "IndentBlanklineIndent4",
        --   "IndentBlanklineIndent5",
        --   "IndentBlanklineIndent6",
        -- },
    }
}
