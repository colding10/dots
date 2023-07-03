local icon = require("core.icons")

return {
    "utilyre/barbecue.nvim",
    event = { "BufReadPost", "BufNewFile" },
    dependencies = { "SmiteshP/nvim-navic", "nvim-tree/nvim-web-devicons" },
    opts = {
        theme = "auto",
        include_buftypes = { "" },
        exclude_filetypes = { "gitcommit", "Trouble", "toggleterm" },
        show_modified = false,
        kinds = icon.kinds
    }
}
