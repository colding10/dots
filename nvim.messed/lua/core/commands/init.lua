local commands = {}

local keymaps_folder_path = vim.fn.stdpath("config") .. "/lua/core/commands/"
local files = vim.fn.glob(keymaps_folder_path .. "*.lua", true, true)

for _, file in ipairs(files) do
    local filename = vim.fn.fnamemodify(file, ":t")

    if filename ~= "init.lua" then
        local command_list = assert(loadfile(file))()

        for _, command in ipairs(command_list) do
            table.insert(commands, command)
        end
    end
end

return commands
