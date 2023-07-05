return {
    "nvim-treesitter/nvim-treesitter",
    event = "BufReadPre",
    build = ":TSUpdate",
    opts = {
        highlight = {
            enable = true
        },
        indent = {
            enable = true
        },
        ensure_installed = {"bash", "c", "cpp", "html", "javascript", "json", "lua", "luadoc", "luap", "markdown",
                            "markdown_inline", "python", "query", "regex", "rust", "tsx", "typescript", "vim", "vimdoc", "yaml"}

        -- incremental_selection = {
        --     enable = true,
        --     keymaps = {
        --         init_selection = "<C-space>",
        --         node_incremental = "<C-space>",
        --         scope_incremental = false,
        --         node_decremental = "<bs>"
        --     }
        -- }
    },
    ---@param opts TSConfig
    config = function(_, opts)
        if type(opts.ensure_installed) == "table" then
            ---@type table<string, boolean>
            local added = {}
            opts.ensure_installed = vim.tbl_filter(function(lang)
                if added[lang] then
                    return false
                end
                added[lang] = true
                return true
            end, opts.ensure_installed)
        end
        require("nvim-treesitter.configs").setup(opts)
    end
}
