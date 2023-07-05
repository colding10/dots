return {
    "rebelot/heirline.nvim",
    lazy = false,
    opts = function()
        require("heirline").setup({
            statusline = require("config.heirline.statusline"),
            -- winbar = require("config.heirline.winbar"),
            -- tabline = require("config.heirline.tabline"),
            -- statuscolumn = require("config.heirline.statuscolumn"),

            -- opts = {

            -- }
        })
    end
}
