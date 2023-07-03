local core_conf_files = {
  "globals.lua", -- some global settings
  "autocommands.vim", -- various autocommands

  "plugins.vim", -- all the plugins installed and their configurations

  "options.vim", -- setting options in nvim
  "colorschemes.lua", -- colorscheme settings
  "mappings.lua", -- all the user-defined mappings
}

-- source all the core config files
for _, name in ipairs(core_conf_files) do
  local path = string.format("%s/core/%s", vim.fn.stdpath("config"), name)
  local source_cmd = "source " .. path
  vim.cmd(source_cmd)
end
