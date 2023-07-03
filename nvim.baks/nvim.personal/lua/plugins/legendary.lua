M = {
    'mrjones2014/legendary.nvim', -- sqlite is only needed if you want to use frecency sorting
    event = "VeryLazy",
    dependencies = {'kkharji/sqlite.lua'}
}

M.config = function()
    require("legendary").setup({
        keymaps = {
            {"<C-S-P>", ":Legendary<CR>", description = "Trigger legendary command finding", opts={silent=true}},

            -- LSP KEYMAPS
            {"<F2>", vim.lsp.buf.rename, description = "Rename the current variable"},
            {"<C-K>", vim.lsp.buf.hover, description = "Show hover info for variable"},
            {"Ï", vim.lsp.buf.format, description = "Format current buffer"},

            -- TELESCOPE KEYMAPS
            {"<c-P>", require("telescope.builtin").find_files, opts = { silent = true }},
        },

        autocmds = {
            
        }
    })
end

return M
