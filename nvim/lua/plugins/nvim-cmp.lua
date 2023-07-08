return {
    "hrsh7th/nvim-cmp",
    version = false,
    event = {"InsertEnter", "CmdlineEnter"},
    dependencies = {"hrsh7th/cmp-nvim-lsp", "hrsh7th/cmp-buffer", "hrsh7th/cmp-path",
                    "hrsh7th/cmp-cmdline"},
    opts = function()
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
                }),
            }),

            sources = cmp.config.sources({
                {name = "nvim_lsp", keyword_length = 1},
                {name = "buffer", keyword_length = 3},
                {name = "path", keyword_length = 3}
            }),
  
            formatting = {
                fields = {"abbr", "kind", "menu"},
                format = function(entry, item)
                    local icons = require("core.icons").kinds
					item.menu = item.kind
                    item.kind = icons[item.kind]
                    return item
                end
            },
            experimental = {
                ghost_text = true
            }
        }
    end
}
