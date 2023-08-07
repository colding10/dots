return {
    "hrsh7th/nvim-cmp",
    version = false,
    event = {"InsertEnter", "CmdlineEnter"},
    dependencies = {"hrsh7th/cmp-nvim-lsp", "hrsh7th/cmp-buffer", "hrsh7th/cmp-path", "hrsh7th/cmp-cmdline"},
    opts = function(_, opts)
        local cmp = require("cmp")

        cmp.setup.cmdline("/", {
            mapping = cmp.mapping.preset.cmdline(),
            sources = {{
                name = "buffer"
            }}
        })
        cmp.setup.cmdline(":", {
            mapping = cmp.mapping.preset.cmdline(),
            sources = cmp.config.sources({{
                name = "path"
            }}, {{
                name = "cmdline"
            }})
        })

        return {
            completion = {
                completeopt = "menu,menuone,noinsert"
            },
            window = {
                completion = cmp.config.window.bordered(),
                documentation = cmp.config.window.bordered()
            },
            snippet = {
                expand = function(args)
                    require('luasnip').lsp_expand(args.body) -- For `luasnip` users.
                end
            },
            mapping = cmp.mapping.preset.insert({
                ["<C-j>"] = cmp.mapping(cmp.mapping.select_next_item({
                    behavior = cmp.SelectBehavior.Insert
                }), {"i", "c"}),
                ["<C-k>"] = cmp.mapping(cmp.mapping.select_prev_item({
                    behavior = cmp.SelectBehavior.Insert
                }), {"i", "c"}),
                ["<C-b>"] = cmp.mapping.scroll_docs(-4),
                ["<C-f>"] = cmp.mapping.scroll_docs(4),
                ["<C-Space>"] = cmp.mapping.complete(),
                ["<C-e>"] = cmp.mapping.abort(),
                ["<ESC>"] = cmp.mapping.abort(),
                ["<CR>"] = cmp.mapping.confirm({
                    select = true
                }), -- Accept currently selected item. Set `select` to `false` to only confirm explicitly selected items.
                ["<Tab>"] = cmp.mapping.select_next_item({
                    behavior = cmp.SelectBehavior.Insert
                }),
                ["<S-Tab>"] = cmp.mapping.select_prev_item({
                    behavior = cmp.SelectBehavior.Insert
                })
            }),

            sources = cmp.config.sources({{
                name = "nvim_lsp",
                keyword_length = 1
            }, {
                name = "buffer",
                keyword_length = 3
            }, {
                name = "nvim_lua"
            }}),

            formatting = {
                format = function(entry, vim_item)
                    -- Kind icons
                    vim_item.kind = string.format("%s %s", kind_icons[vim_item.kind], vim_item.kind) -- This concatonates the icons with the name of the item kind
                    -- Source
                    vim_item.menu = ({
                        buffer = "[Buffer]",
                        nvim_lsp = "[LSP]",
                        luasnip = "[LuaSnip]",
                        nvim_lua = "[Lua]",
                        latex_symbols = "[LaTeX]"
                    })[entry.source.name]
                    return vim_item
                end
            }
        }
    end
}
