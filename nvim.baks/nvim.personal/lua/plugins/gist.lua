return {{
    "Rawnly/gist.nvim",
    cmd = {"GistCreate", "GistCreateFromFile", "GistsList"},
    config = true
}, -- `GistsList` opens the selected gif in a terminal buffer,
{
    "samjwill/nvim-unception", -- nvim-unception uses neovim remote rpc functionality to open the gist in an actual buffer
    lazy = false, -- and prevents neovim buffer inception
    init = function()
        vim.g.unception_block_while_host_edits = true
    end
}}
