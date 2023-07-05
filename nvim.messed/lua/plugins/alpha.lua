return {
    "goolord/alpha-nvim",
    event = "VimEnter",
    opts = function()
        local dashboard               = require("alpha.themes.dashboard")
        local logo                    = require("core.logo")

        dashboard.section.header.val  = vim.split(logo, "\n")
        dashboard.section.buttons.val = {
            dashboard.button("e", "  > New file", ":ene <BAR> startinsert <CR>"),
            dashboard.button("f", "  > Find file", ":cd $HOME | Telescope find_files<CR>"),
            dashboard.button("r", "  > Recent", ":Telescope oldfiles<CR>"),
            dashboard.button("p", "  > Restore session", ':lua require("persistence").load() <cr>'),
            dashboard.button("l", "󰤄  > Lazy", ":Lazy<CR>"),
            dashboard.button("m", "  > Mason", ":Mason<CR>"),
            dashboard.button("s", "  > Settings", ":e $MYVIMRC | :cd %:p:h | pwd | Neotree<CR>"),
            dashboard.button("q", "  > Quit NVIM", ":qa<CR>"),
        }

        dashboard.opts.layout[1].val  = 8
        return dashboard
    end,

    config = function(_, dashboard)
        if vim.o.filetype == "lazy" then
            vim.cmd.close()
            vim.api.nvim_create_autocmd("User", {
                pattern = "AlphaReady",
                callback = function()
                    require("lazy").show()
                end,
            })
        end

        require("alpha").setup(dashboard.opts)
    end,
}
