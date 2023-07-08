local util = require("util")

return {
    "nvim-telescope/telescope.nvim",
    dependencies = {{"debugloop/telescope-undo.nvim"}, {
        'nvim-telescope/telescope-fzf-native.nvim',
        build = 'cmake -S. -Bbuild -DCMAKE_BUILD_TYPE=Release && cmake --build build --config Release && cmake --install build --prefix build'
    }},

    cmd = "Telescope",
    opts = {
        defaults = {
            prompt_prefix = "   ",
            selection_caret = "  ",
            entry_prefix = "   ",
            dynamic_preview_title = true,
            hl_result_eol = true,
            sorting_strategy = "ascending",
            file_ignore_patterns = {".git/", "target/", "docs/", "vendor/*", "%.lock", "__pycache__/*", "%.sqlite3",
                                    "%.ipynb", "node_modules/*", "%.jpg", "%.jpeg", "%.png", "%.svg", "%.otf", "%.ttf",
                                    "%.webp", ".dart_tool/", ".github/", ".gradle/", ".idea/", ".settings/", ".vscode/",
                                    "__pycache__/", "build/", "gradle/", "node_modules/", "%.pdb", "%.dll", "%.class",
                                    "%.exe", "%.cache", "%.ico", "%.pdf", "%.dylib", "%.jar", "%.docx", "%.met",
                                    "smalljre_*/*", ".vale/", "%.burp", "%.mp4", "%.mkv", "%.rar", "%.zip", "%.7z",
                                    "%.tar", "%.bz2", "%.epub", "%.flac", "%.tar.gz"},
            results_title = "",
            layout_config = {
                horizontal = {
                    prompt_position = "top"
                    -- preview_width = 0.55,
                    -- results_width = 0.8
                },
                vertical = {
                    mirror = false
                },
                -- width = 0.87,
                -- height = 0.80,
                layout_strategy = "flex"
            }
        }
    },
    config = function()
        require("telescope").setup({
            extensions = {
                undo = {
                    -- telescope-undo.nvim config, see below
                },
                fzf = {
                    fuzzy = true, -- false will only do exact matching
                    override_generic_sorter = true, -- override the generic sorter
                    override_file_sorter = true, -- override the file sorter
                    case_mode = "smart_case" -- or "ignore_case" or "respect_case"
                }
            }
        })
        require("telescope").load_extension("undo")
        require('telescope').load_extension('fzf')
        require('telescope').load_extension("notify")
    end
}
