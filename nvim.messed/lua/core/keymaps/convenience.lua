return {
    {
        "<leader><leader>",
        ":",
        desc = "Shorter command line",

        opts = {silent=false}
    },

    {
        "<leader>w",
        ":w",
        desc = "Save file"
    },
    
    {
        "<leader>p",
        ":Legendary<CR>",
        desc = "Trigger legendary command finding"
    },

    {
        "jk",
        "<ESC>",

        mode = {"i"},
        desc = "Press jk fast to exit insert"
    },
}