return {
    'VonHeikemen/lsp-zero.nvim',
    branch = 'v2.x',
    dependencies = {{'neovim/nvim-lspconfig'}, {'williamboman/mason.nvim'}, {'williamboman/mason-lspconfig.nvim'},

                    {'hrsh7th/nvim-cmp'}, {'hrsh7th/cmp-nvim-lsp'}, {'L3MON4D3/LuaSnip'}},
    config = function()
        local lsp = require('lsp-zero').preset({})

        lsp.on_attach(function(client, bufnr)
            lsp.default_keymaps({
                buffer = bufnr
            })
        end)

        require('lspconfig').lua_ls.setup(lsp.nvim_lua_ls())
        require('lspconfig').pyright.setup({})

        local capabilities = vim.lsp.protocol.make_client_capabilities()
        capabilities.offsetEncoding = {"utf-16"}
        require("lspconfig").clangd.setup({
            capabilities = capabilities
        })

        require('mason').setup()
        require('mason-lspconfig').setup()

        lsp.ensure_installed({
            'tsserver',
            'eslint',
            'rust_analyzer',
            'lua_ls',
            'pyright',
            'clangd',
            'jdtls'
        })
        lsp.setup()
          

        -- You need to setup `cmp` after lsp-zero
        local cmp = require('cmp')
        local cmp_action = require('lsp-zero').cmp_action()

        cmp.setup({
            mapping = {
                ['<CR>'] = cmp.mapping.confirm({
                    select = true
                }),

                ["<Tab>"] = cmp.mapping(function(fallback)
                    if cmp.visible() then
                        cmp.select_next_item()
                    else
                        fallback()
                    end
                end, {"i", "s"}),

                ["<S-Tab>"] = cmp.mapping(function(fallback)
                    if cmp.visible() then
                        cmp.select_prev_item()
                    else
                        fallback()
                    end
                end, {"i", "s"}),

                -- Ctrl+Space to trigger completion menu
                ['<C-Space>'] = cmp.mapping.complete(),

                -- Navigate between snippet placeholder
                ['<C-f>'] = cmp_action.luasnip_jump_forward(),
                ['<C-b>'] = cmp_action.luasnip_jump_backward()
            }
        })

        vim.diagnostic.config({
            virtual_text = false,
            float = {
                focusable = false,
                style = "minimal",
                border = "rounded",
                source = "always",
                header = "",
                prefix = ""
            },
            signs = true,
            underline = true,
            update_in_insert = true,
            severity_sort = false
        })

        ---- sign column
        local signs = {
            Error = "✖ ",
            Warn = "! ",
            Hint = "󰌶 ",
            Info = " "
        }

        for type, icon in pairs(signs) do
            local hl = "DiagnosticSign" .. type
            vim.fn.sign_define(hl, {
                text = icon,
                texthl = hl,
                numhl = hl
            })
        end
    end
}
