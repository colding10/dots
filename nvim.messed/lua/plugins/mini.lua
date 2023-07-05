return {
    {
        "echasnovski/mini.pairs",
        event = "BufReadPre",
        config = function(_, opts)
            require("mini.pairs").setup(opts)
        end
    }, 

    {
        "echasnovski/mini.align",
        version = false,
        event = "BufReadPre",
        config = function()
            require("mini.align").setup()
        end
    }
}
