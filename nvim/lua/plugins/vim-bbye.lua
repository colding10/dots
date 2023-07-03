return {
    "moll/vim-bbye",
    event = {"BufRead"},
    keys = {{
        "<leader>d",
        "<cmd>Bdelete!<cr>",
        desc = "Close Buffer"
    }}
}
