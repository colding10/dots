return {
    {
        "nvim-treesitter/playground",
        cmd = "TSPlaygroundToggle"
    }, 
    
    {
        "nvim-treesitter/nvim-treesitter-context",
        event = "BufReadPre",
        enabled = true,
        opts = {
            mode = "cursor"
        }
    },

    {
        "nvim-treesitter/nvim-treesitter",
        event = "BufReadPre",
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
        end,

        opts = {
            ensure_installed = {"bash", "c", "cmake", "cpp", "gitignore", "java", "lua", 
                                "luap", "markdown", "markdown_inline", "ninja", "org",
                                "python", "query", "regex", "rust", "vim", "vimdoc"},
            matchup = {
                enable = true
            },
            highlight = { 
                enable = true 
            },
            indent = {
                enable = true
            },
            autotag = {
                enable = true
            },
            incremental_selection = {
                enable = true
            },
            
            query_linter = {
                enable = true,
                use_virtual_text = true,
                lint_events = {"BufWrite", "CursorHold"}
            },
            playground = {
                enable = true,
                disable = {},
                updatetime = 25, -- Debounced time for highlighting nodes in the playground from source code
                persist_queries = true, -- Whether the query persists across vim sessions
                keybindings = {
                    toggle_query_editor = "o",
                toggle_hl_groups = "i",
                toggle_injected_languages = "t",
                toggle_anonymous_nodes = "a",
                toggle_language_display = "I",
                focus_language = "f",
                unfocus_language = "F",
                update = "R",
                goto_node = "<cr>",
                show_help = "?"
            }
        }
    }
    }, 

    {
        "nvim-treesitter/nvim-treesitter",
        dependencies = {{
            "windwp/nvim-ts-autotag",
            opts = {}
        }}
    }
}
