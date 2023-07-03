return {
    "ghillb/cybu.nvim",
    event = "VeryLazy",
    branch = "main", -- branch with timely updates
    config = function()
        require("cybu").setup()
        vim.keymap.set("n", "K", "<Plug>(CybuPrev)")
        vim.keymap.set("n", "J", "<Plug>(CybuNext)")
        vim.keymap.set("n", "<c-s-tab>", "<plug>(CybuLastusedPrev)")
        vim.keymap.set("n", "<c-tab>", "<plug>(CybuLastusedNext)")
    end
}
