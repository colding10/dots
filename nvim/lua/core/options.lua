vim.loader.enable()

-- Remap space as leader key
vim.g.mapleader = " "
vim.g.maplocalleader = " "
vim.g.auto_save = 1

vim.opt.clipboard = "unnamedplus"
vim.opt.undofile = true
vim.opt.pumheight = 20 -- pop up menu height
vim.opt.swapfile = false
vim.opt.ignorecase = true
vim.opt.smartcase = true -- smart case
vim.opt.smartindent = true -- smart indent
vim.opt.showmode = false -- we don't need to see things like -- INSERT -- anymore
vim.opt.sidescrolloff = 5 -- how many lines to scroll when using the scrollbar
vim.opt.autoindent = true
vim.opt.signcolumn = "yes"

vim.opt.expandtab = true
vim.opt.showcmd = true
vim.opt.swapfile = false
vim.opt.termguicolors = true
vim.opt.updatetime = 100
vim.opt.writebackup = false
vim.opt.number = true
vim.opt.relativenumber = true
vim.opt.jumpoptions = "view"

vim.opt.shiftwidth = 4
vim.opt.tabstop = 4
vim.opt.expandtab = true

vim.opt.laststatus = 3
vim.opt.cmdheight = 0 -- off for folke/noice.nvim
vim.opt.list = true
vim.opt.splitkeep = "screen"
vim.opt.syntax = "on"
vim.opt.spelloptions = "camel,noplainbuffer"
vim.opt.foldlevel = 99
vim.o.foldcolumn = "1"
vim.o.foldlevelstart = 99
vim.opt.foldenable = true
vim.opt.mousemoveevent = true

-- command completion
vim.opt.wildmode = "longest:full:full"
vim.opt.wildignore = "*.docx,*.jpg,*.png,*.gif,*.pdf,*.pyc,*.exe,*.flv,*.img,*.xlsx,*DS_STORE,*.db"
