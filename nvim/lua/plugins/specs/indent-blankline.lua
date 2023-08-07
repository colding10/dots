return {
    "lukas-reineke/indent-blankline.nvim",
    event = {"BufReadPost", "BufNewFile"},
    opts = {
        char = "▏",
        context_char = "▏",
        show_end_of_line = false,
        space_char_blankline = " ",
        filetype_exclude = {"help", "startify", "dashboard", "lazy", "neogitstatus", "Trouble", "alpha", "neo-tree"},
        buftype_exclude = {"terminal", "nofile"}
    }
}
