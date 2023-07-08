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

    {
        "olimorris/onedarkpro.nvim",
        priority = 1000 -- Ensure it loads first
    },


    {
        "rebelot/kanagawa.nvim",
        lazy = false,
        priority = 1000,
        opts = {}
    },

    {
        "tanvirtin/monokai.nvim",
        lazy = false,
        priority = 1000,
        opts = {}
    }
}
