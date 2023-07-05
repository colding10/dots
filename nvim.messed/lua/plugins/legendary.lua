M = {
    'mrjones2014/legendary.nvim', -- sqlite is only needed if you want to use frecency sorting
    event = "VeryLazy",
    dependencies = {'kkharji/sqlite.lua'}
}

M.config = function()
    require("legendary").setup({
        default_opts = {
            keymaps = { -- for example, { silent = true, remap = false }
                silent = true,
                remap = true
            },
            commands = {}, -- for example, { args = '?', bang = true }
            autocmds = {} -- for example, { buf = 0, once = true }
        },

        keymaps = require("core.keymaps.init"),
        commands = require("core.commands.init"),
        autocmds = {}
    })
end

return M
