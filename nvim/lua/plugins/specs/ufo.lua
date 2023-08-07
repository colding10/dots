return {
    "kevinhwang91/nvim-ufo",
    event = {"BufReadPost", "BufNewFile"},
    dependencies = {
        "kevinhwang91/promise-async",
        event = "BufReadPost"
    },
    opts = {
        fold_virt_text_handler = function(virtText, lnum, endLnum, width, truncate)
            local newVirtText = {}
            local suffix = ("  … %d "):format(endLnum - lnum)
            local sufWidth = vim.fn.strdisplaywidth(suffix)
            local targetWidth = width - sufWidth
            local curWidth = 0
            for _, chunk in ipairs(virtText) do
                local chunkText = chunk[1]
                local chunkWidth = vim.fn.strdisplaywidth(chunkText)
                if targetWidth > curWidth + chunkWidth then
                    table.insert(newVirtText, chunk)
                else
                    chunkText = truncate(chunkText, targetWidth - curWidth)
                    local hlGroup = chunk[2]
                    table.insert(newVirtText, {chunkText, hlGroup})
                    chunkWidth = vim.fn.strdisplaywidth(chunkText)
                    -- str width returned from truncate() may less than 2nd argument, need padding
                    if curWidth + chunkWidth < targetWidth then
                        suffix = suffix .. (" "):rep(targetWidth - curWidth - chunkWidth)
                    end
                    break
                end
                curWidth = curWidth + chunkWidth
            end
            table.insert(newVirtText, {suffix, "MoreMsg"})
            return newVirtText
        end,
        open_fold_hl_timeout = 0
    },
    keys = {{
        "fd",
        "zd",
        desc = "Delete fold under cursor"
    }, {
        "fo",
        "zo",
        desc = "Open fold under cursor"
    }, {
        "fO",
        "zO",
        desc = "Open all folds under cursor"
    }, {
        "fc",
        "zC",
        desc = "Close all folds under cursor"
    }, {
        "fa",
        "za",
        desc = "Toggle fold under cursor"
    }, {
        "fA",
        "zA",
        desc = "Toggle all folds under cursor"
    }, {
        "fv",
        "zv",
        desc = "Show cursor line"
    }, {
        "fM",
        function()
            require("ufo").closeAllFolds()
        end,
        desc = "Close all folds"
    }, {
        "fR",
        function()
            require("ufo").openAllFolds()
        end,
        desc = "Open all folds"
    }, {
        "fm",
        "zm",
        desc = "Fold more"
    }, {
        "fr",
        "zr",
        desc = "Fold less"
    }, {
        "fx",
        "zx",
        desc = "Update folds"
    }, {
        "fz",
        "zz",
        desc = "Center this line"
    }, {
        "ft",
        "zt",
        desc = "Top this line"
    }, {
        "fb",
        "zb",
        desc = "Bottom this line"
    }, {
        "fg",
        "zg",
        desc = "Add word to spell list"
    }, {
        "fw",
        "zw",
        desc = "Mark word as bad/misspelling"
    }, {
        "fe",
        "ze",
        desc = "Right this line"
    }, {
        "fE",
        "zE",
        desc = "Delete all folds in current buffer"
    }, {
        "fs",
        "zs",
        desc = "Left this line"
    }, {
        "fH",
        "zH",
        desc = "Half screen to the left"
    }, {
        "fL",
        "zL",
        desc = "Half screen to the right"
    }}
}, {
    "luukvbaal/statuscol.nvim",
    event = {"BufReadPost", "BufNewFile"},
    config = function()
        local builtin = require("statuscol.builtin")
        require("statuscol").setup({
            relculright = false,
            ft_ignore = {"neo-tree"},
            segments = {{
                -- line number
                text = {" ", builtin.lnumfunc},
                condition = {true, builtin.not_empty},
                click = "v:lua.ScLa"
            }, {
                text = {"%s"},
                click = "v:lua.ScSa"
            }, -- Sign
            {
                text = {builtin.foldfunc, " "},
                click = "v:lua.ScFa"
            } -- Fold
            }
        })
        vim.api.nvim_create_autocmd({"BufEnter"}, {
            callback = function()
                if vim.bo.filetype == "neo-tree" then
                    vim.opt_local.statuscolumn = ""
                end
            end
        })
    end
}
