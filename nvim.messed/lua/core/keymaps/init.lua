local keymaps = {}

local keymaps_folder_path = vim.fn.stdpath("config") .. "/lua/core/keymaps/"
local files = vim.fn.glob(keymaps_folder_path .. "*.lua", true, true)

for _, file in ipairs(files) do
    local filename = vim.fn.fnamemodify(file, ":t")

    if filename ~= "init.lua" then
        local keymap = assert(loadfile(file))()

        for _, binding in ipairs(keymap) do
            table.insert(keymaps, binding)
        end
    end
end

return keymaps
