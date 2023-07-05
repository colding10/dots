local vimode = require("config.heirline.statusline.vimode")
local filename = require("config.heirline.statusline.filename")

local ruler = require("config.heirline.statusline.ruler")
local scrollbar = require("config.heirline.statusline.scrollbar")

local diagnostic = require("config.heirline.statusline.diagnostic")

local lspactive = require("config.heirline.statusline.lspactive")

local filetype = require('config.heirline.statusline.filetype')
local navic = require("config.heirline.statusline.navic")


local ALIGN = { provider = "%=" }
local SPACE = { provider = " " }

local DefaultStatusline = {
    vimode, SPACE, filename, SPACE, diagnostic, ALIGN,
    navic, ALIGN,
    lspactive, SPACE, filetype, SPACE, ruler, SPACE, scrollbar
}

return DefaultStatusline