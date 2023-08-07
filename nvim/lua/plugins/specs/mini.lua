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
    },

    {
        "echasnovski/mini.files",
        version = false,
        event = "BufReadPre",
        config = function()
            require("mini.files").setup()
        end
    },

    {
        "echasnovski/mini.bufremove",
        -- stylua: ignore
        keys = {
          { "<leader>bd", function() require("mini.bufremove").delete(0, false) end, desc = "Delete Buffer" },
          { "<leader>bD", function() require("mini.bufremove").delete(0, true) end, desc = "Delete Buffer (Force)" },
        },
    }
}
