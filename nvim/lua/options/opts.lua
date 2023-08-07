local o = vim.o
local g = vim.g

vim.loader.enable()

-- Remap space as leader key
g.mapleader = " "
g.maplocalleader = " "
g.auto_save = 1

o.clipboard = "unnamedplus"
o.undofile = true
o.pumheight = 20 -- pop up menu height
o.swapfile = false
o.ignorecase = true
o.smartcase = true -- smart case
o.smartindent = true -- smart indent
o.showmode = false -- we don't need to see things like -- INSERT -- anymore
o.sidescrolloff = 5 -- how many lines to scroll when using the scrollbar
o.autoindent = true
o.signcolumn = "yes"

o.expandtab = true
o.showcmd = true
o.swapfile = false
o.termguicolors = true
o.updatetime = 100
o.writebackup = false
o.number = true
o.relativenumber = true
o.jumpoions = "view"

o.shiftwidth = 4
o.tabstop = 4
o.expandtab = true

o.cursorline = true
o.laststatus = 3
o.cmdheight = 0
o.list = true
o.splitkeep = "screen"
o.syntax = "on"
o.spelloions = "camel,noplainbuffer"

o.foldlevel = 99
o.foldcolumn = "1"
o.foldlevelstart = 99
o.foldenable = true
o.foldmethod = "expr"
o.foldexpr = "nvim_treesitter#foldexpr()"
-- -- o.foldenable = false

o.mousemoveevent = true