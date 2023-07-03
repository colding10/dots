return {
    "folke/persistence.nvim",
    event = "BufReadPre",
    opts = {
        options = {"buffers", "curdir", "tabpages", "winsize", "help", "blank", "terminal", "folds", "tabpages"}
    },
}
