return {
    {
        "folke/tokyonight.nvim",
        lazy = false,
        priority = 1000,
        opts = {}
    },

    {
        "sainnhe/edge",
        lazy = false,
        priority = 1000,
        config = function()
            vim.cmd("colorscheme edge")
        end
    },
}
