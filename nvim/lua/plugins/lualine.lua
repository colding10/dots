return {
    "nvim-lualine/lualine.nvim",
    event = "VeryLazy",
    opts = {},
    config = function()
        local lualine_config = require("config.lualine")
        lualine_config.setup({
            float = false,
            separator = "bubble", -- bubble | triangle
            ---@type any
            colorful = true
        })
        lualine_config.load()
    end
}
