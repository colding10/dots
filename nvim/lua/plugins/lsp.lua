return {
    {
        "neovim/nvim-lspconfig",
        opt = true,
        event = "BufReadPre",
        dependencies = {"williamboman/mason-lspconfig.nvim"},
        config = function()
            require("config.lsp").setup()
        end
    },

    {
        "glepnir/lspsaga.nvim",
        event = "LspAttach",
        config = function()
            require("lspsaga").setup({
                symbol_in_winbar = {
                    enable = false
                }
            })
        end
    },

    {
        "williamboman/mason.nvim",
        event = "VeryLazy",
        build = ":MasonUpdate",
        opts = {
            pip = {
                upgrade_pip = true
            },
            ui = {
                border = "rounded",
                icons = {
                    package_installed = "✓",
                    package_pending = "➜",
                    package_uninstalled = "✗"
                }
            }
        },
        config = function(_, opts)
            require("mason").setup(opts)
            local utils = require("util")
            local mr = require("mason-registry")
            local packages = utils.mason_packages
            local function ensure_installed()
                for _, package in ipairs(packages) do
                    local p = mr.get_package(package)
                    if not p:is_installed() then
                        p:install()
                    end
                end
            end
            if mr.refresh then
                mr.refresh(ensure_installed)
            else
                ensure_installed()
            end
        end
    }
}
