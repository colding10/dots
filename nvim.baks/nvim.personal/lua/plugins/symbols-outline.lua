return {
    "simrat39/symbols-outline.nvim",
    event = "BufEnter",
    config = function()
        require("symbols-outline").setup()
    end
}
