return {
    {
        "<leader>E",
        function()
            require("neo-tree.command").execute({
                toggle = true,
                position = "float",
                dir = require("util").get_root()
            })
        end,
        desc = "Neotree (floating, root dir)"
    },

    {
        "<leader>e",
        function()
            require("neo-tree.command").execute({
                toggle = true,
                position = "left",
                dir = require("util").get_root()
            })
        end,
        desc = "Neotree (root dir)"
    },
}
