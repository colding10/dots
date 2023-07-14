local utils = require("util")
local mr = require("mason-registry")
local mason_lspconfig = require("mason-lspconfig")
local lspconfig = require("lspconfig")
local lsp_utils = require("config.lsp.lsp-utils")

local M = {}

function M.setup(servers, options)
    local utils = require("util")

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

    lsp_utils.setup()

    mason_lspconfig.setup({
        ensure_installed = utils.lsp_servers
    })

    mason_lspconfig.setup_handlers({
        function(server_name)
            lspconfig[server_name].setup({
                on_attach = lsp_utils.on_attach,
                capabilities = lsp_utils.capabilities
            })
        end,

        ["clangd"] = function()
            local capabilities_cpp = lsp_utils.capabilities
            capabilities_cpp.offsetEncoding = {"uts-16"}
            lspconfig.clangd.setup({
                on_attach = lsp_utils.on_attach,
                capabilities = capabilities_cpp
            })
        end
    })
end

return M
