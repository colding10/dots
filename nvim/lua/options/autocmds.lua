
-- Format on save
-- vim.api.nvim_create_autocmd({ "BufWritePre" }, {
--   callback = function()
--     vim.lsp.buf.format()
--   end,
-- }) 

-- Highlight on yank
vim.api.nvim_create_autocmd({ "TextYankPost" }, {
    callback = function()
        vim.highlight.on_yank({ higroup = "Visual" })
    end,
})

-- resize splits if window got resized
vim.api.nvim_create_autocmd({ "VimResized" }, {
    callback = function()
        vim.cmd("tabdo wincmd =")
    end,
})

-- Set wrap and spell in markdown and gitcommit
vim.api.nvim_create_autocmd({ "FileType" }, {
    pattern = { "gitcommit", "markdown" },
    callback = function()
        vim.opt_local.wrap = true
        vim.opt_local.spell = true
    end,
})


-- fix comment
vim.api.nvim_create_autocmd({ "BufEnter", "BufWinEnter" }, {
    pattern = { "*" },
    callback = function()
        vim.cmd([[set formatoptions-=cro]])
    end,
})

vim.api.nvim_create_autocmd({ "BufEnter" }, {
    pattern = { "" },
    callback = function()
        local get_project_dir = function()
            local cwd = vim.fn.getcwd()
            local project_dir = vim.split(cwd, "/")
            local project_name = project_dir[#project_dir]
            return project_name
        end

        vim.opt.titlestring = get_project_dir()
    end,
})

-- clear cmd output
vim.api.nvim_create_autocmd({ "CursorHold" }, {
    callback = function()
        vim.cmd([[echon '']])
    end,
})

vim.api.nvim_create_autocmd({ "FileType" }, {
    pattern = { "help" },
    callback = function()
        vim.cmd([[wincmd L]])
    end,
})

vim.api.nvim_create_autocmd({ "TermOpen" }, {
    pattern = { "*" },
    callback = function()
        vim.opt_local["number"] = false
        vim.opt_local["signcolumn"] = "no"
        vim.opt_local["foldcolumn"] = "0"
    end,
})

-- fix comment on new line
vim.api.nvim_create_autocmd({ "BufEnter", "BufWinEnter" }, {
    pattern = { "*" },
    callback = function()
        vim.cmd([[set formatoptions-=cro]])
    end,
})

-- Auto create dir when saving a file, in case some intermediate directory does not exist
vim.api.nvim_create_autocmd({ "BufWritePre" }, {
    callback = function(event)
        if event.match:match("^%w%w+://") then
            return
        end
        local file = vim.loop.fs_realpath(event.match) or event.match
        vim.fn.mkdir(vim.fn.fnamemodify(file, ":p:h"), "p")
    end,
})
