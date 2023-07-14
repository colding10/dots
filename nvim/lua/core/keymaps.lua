local opts = {
    noremap = true,
    silent = true
}

-- Shorten function name
local keymap = vim.api.nvim_set_keymap


-- Modes
--   normal_mode = "n",
--   insert_mode = "i",
--   visual_mode = "v",
--   visual_block_mode = "x",
--   term_mode = "t",
--   command_mode = "c",

-------------------- Stay in indent mode ------------------------
keymap("v", "<", "<gv", opts)
keymap("v", ">", ">gv", opts)
keymap("v", "p", '"_dP', opts)

-------------------- Resize windows ----------------------------
keymap("n", "<A-C-j>", ":resize +1<CR>", opts)
keymap("n", "<A-C-k>", ":resize -1<CR>", opts)
keymap("n", "<A-C-h>", ":vertical resize +1<CR>", opts)
keymap("n", "<A-C-l>", ":vertical resize -1<CR>", opts)

-------------------- Move text up/ down ------------------------
-- Visual --
keymap("v", "<A-S-j>", ":m .+1<CR>==", opts)
keymap("v", "<A-S-k>", ":m .-2<CR>==", opts)
-- Block --
-- keymap("x", "J", ":move '>+1<CR>gv-gv", opts)
-- keymap("x", "K", ":move '<-2<CR>gv-gv", opts)
keymap("x", "<A-S-j>", ":move '>+1<CR>gv-gv", opts)
keymap("x", "<A-S-k>", ":move '<-2<CR>gv-gv", opts)
-- Normal --
keymap("n", "<A-S-j>", ":m .+1<CR>==", opts)
keymap("n", "<A-S-k>", ":m .-2<CR>==", opts)
-- Insert --
keymap("i", "<A-S-j>", "<ESC>:m .+1<CR>==gi", opts)
keymap("i", "<A-S-k>", "<ESC>:m .-2<CR>==gi", opts)


-------------------- split window ------------------------------
keymap("n", "<leader>\\", ":vsplit<CR>", opts)
keymap("n", "<leader>/", ":split<CR>", opts)

-------------------- Switch two windows ------------------------
keymap("n", "<A-o>", "<C-w>r", opts)

--     -- LSP KEYMAPS
        --     { "<F2>",    vim.lsp.buf.rename,                      description = "Rename the current variable" },
        --     { "<C-K>",   vim.lsp.buf.hover,                       description = "Show hover info for variable" },

        --     -- TELESCOPE KEYMAPS
        --     { "<c-P>",   require("telescope.builtin").find_files, opts = { silent = true } },
        -- },
        
-------------------- fuzzy search --------------------------------
vim.keymap.set("n", "<C-f>", function()
    -- You can pass additional configuration to telescope to change theme, layout, etc.
    require("telescope.builtin").current_buffer_fuzzy_find(require("telescope.themes"))
end, {
    desc = "[/] Fuzzily search in current buffer]"
})

--- OLD SECTIOn
local keymap = vim.keymap
local api = vim.api
local uv = vim.loop

keymap.set({"n", "i"}, "<F5>", "<cmd>ToggleTerm direction=float<CR>", {
    silent = true
})

keymap.set({"n", "x"}, ";", ":") -- Save key strokes (now we do not need to press shift to enter command mode).
keymap.set("c", ";;", "<C-c>") 

keymap.set("i", "<c-u>", "<Esc>viwUea") -- Turn the word under cursor to upper case
keymap.set("i", "<c-t>", "<Esc>b~lea") -- Turn the current word into title case

-- Paste non-linewise text above or below current line, see https://stackoverflow.com/a/1346777/6064933
keymap.set("n", "<leader>p", "m`o<ESC>p``", {
    desc = "paste below current line"
})
keymap.set("n", "<leader>P", "m`O<ESC>p``", {
    desc = "paste above current line"
})

-- Shortcut for faster save and quit
keymap.set("n", "<leader>w", "<cmd>update<cr>", {
    silent = true,
    desc = "save buffer"
})

-- Saves the file if modified and quit
keymap.set("n", "<leader>q", "<cmd>x<cr>", {
    silent = true,
    desc = "quit current window"
})

-- Quit all opened buffers
keymap.set("n", "<leader>Q", "<cmd>qa!<cr>", {
    silent = true,
    desc = "quit nvim"
})

-- Navigation in the location and quickfix list
keymap.set("n", "[l", "<cmd>lprevious<cr>zv", {
    silent = true,
    desc = "previous location item"
})
keymap.set("n", "]l", "<cmd>lnext<cr>zv", {
    silent = true,
    desc = "next location item"
})

keymap.set("n", "[L", "<cmd>lfirst<cr>zv", {
    silent = true,
    desc = "first location item"
})
keymap.set("n", "]L", "<cmd>llast<cr>zv", {
    silent = true,
    desc = "last location item"
})

keymap.set("n", "[q", "<cmd>cprevious<cr>zv", {
    silent = true,
    desc = "previous qf item"
})
keymap.set("n", "]q", "<cmd>cnext<cr>zv", {
    silent = true,
    desc = "next qf item"
})

keymap.set("n", "[Q", "<cmd>cfirst<cr>zv", {
    silent = true,
    desc = "first qf item"
})
keymap.set("n", "]Q", "<cmd>clast<cr>zv", {
    silent = true,
    desc = "last qf item"
})

-- Close location list or quickfix list if they are present, see https://superuser.com/q/355325/736190
keymap.set("n", [[\x]], "<cmd>windo lclose <bar> cclose <cr>", {
    silent = true,
    desc = "close qf and location list"
})

-- Delete a buffer, without closing the window, see https://stackoverflow.com/q/4465095/6064933
keymap.set("n", [[\d]], "<cmd>bprevious <bar> bdelete #<cr>", {
    silent = true,
    desc = "delete buffer"
})

-- Insert a blank line below or above current line (do not move the cursor),
-- see https://stackoverflow.com/a/16136133/6064933
keymap.set("n", "<space>o", "printf('m`%so<ESC>``', v:count1)", {
    expr = true,
    desc = "insert line below"
})

keymap.set("n", "<space>O", "printf('m`%sO<ESC>``', v:count1)", {
    expr = true,
    desc = "insert line above"
})

-- Move the cursor based on physical lines, not the actual lines.
keymap.set("n", "j", "v:count == 0 ? 'gj' : 'j'", {
    expr = true
})
keymap.set("n", "k", "v:count == 0 ? 'gk' : 'k'", {
    expr = true
})
keymap.set("n", "^", "g^")
keymap.set("n", "0", "g0")

-- Do not include white space characters when using $ in visual mode,
keymap.set("x", "$", "g_")

-- Go to start or end of line easier
keymap.set({"n", "x"}, "H", "^")
keymap.set({"n", "x"}, "L", "g_")

-- Continuous visual shifting (does not exit Visual mode), `gv` means
-- to reselect previous visual area, see https://superuser.com/q/310417/736190
keymap.set("x", "<", "<gv")
keymap.set("x", ">", ">gv")

-- Edit and reload nvim config file quickly
keymap.set("n", "<leader>ev", "<cmd>tabnew $MYVIMRC <bar> tcd %:h<cr>", {
    silent = true,
    desc = "open init.lua"
})

keymap.set("n", "<leader>sv", function()
    vim.cmd([[
      update $MYVIMRC
      source $MYVIMRC
    ]])
    vim.notify("Nvim config successfully reloaded!", vim.log.levels.INFO, {
        title = "nvim-config"
    })
end, {
    silent = true,
    desc = "reload init.lua"
})

-- Reselect the text that has just been pasted, see also https://stackoverflow.com/a/4317090/6064933.
keymap.set("n", "<leader>v", "printf('`[%s`]', getregtype()[0])", {
    expr = true,
    desc = "reselect last pasted area"
})

-- Always use very magic mode for searching
-- keymap.set("n", "/", [[/\v]])

-- Search in selected region
-- xnoremap / :<C-U>call feedkeys('/\%>'.(line("'<")-1).'l\%<'.(line("'>")+1)."l")<CR>

-- Change current working directory locally and print cwd after that,
-- see https://vim.fandom.com/wiki/Set_working_directory_to_the_current_file
keymap.set("n", "<leader>cd", "<cmd>lcd %:p:h<cr><cmd>pwd<cr>", {
    desc = "change cwd"
})

-- Use Esc to quit builtin terminal
keymap.set("t", "<Esc>", [[<c-\><c-n>]])

-- Toggle spell checking
keymap.set("n", "<F11>", "<cmd>set spell!<cr>", {
    desc = "toggle spell"
})
keymap.set("i", "<F11>", "<c-o><cmd>set spell!<cr>", {
    desc = "toggle spell"
})

-- Change text without putting it into the vim register,
-- see https://stackoverflow.com/q/54255/6064933
keymap.set("n", "c", '"_c')
keymap.set("n", "C", '"_C')
keymap.set("n", "cc", '"_cc')
keymap.set("x", "c", '"_c')

-- Remove trailing whitespace characters
keymap.set("n", "<leader><space>", "<cmd>StripTrailingWhitespace<cr>", {
    desc = "remove trailing space"
})

-- check the syntax group of current cursor position
keymap.set("n", "<leader>st", "<cmd>call utils#SynGroup()<cr>", {
    desc = "check syntax group"
})

-- Copy entire buffer.
keymap.set("n", "<leader>y", "<cmd>%yank<cr>", {
    desc = "yank entire buffer"
})

-- Toggle cursor column
keymap.set("n", "<leader>cl", "<cmd>call utils#ToggleCursorCol()<cr>", {
    desc = "toggle cursor column"
})

-- Move current line up and down
keymap.set("n", "<A-k>", '<cmd>call utils#SwitchLine(line("."), "up")<cr>', {
    desc = "move line up"
})
keymap.set("n", "<A-j>", '<cmd>call utils#SwitchLine(line("."), "down")<cr>', {
    desc = "move line down"
})

-- Replace visual selection with text in register, but not contaminate the register,
-- see also https://stackoverflow.com/q/10723700/6064933.
keymap.set("x", "p", '"_c<Esc>p')

-- Switch windows
keymap.set("n", "<left>", "<c-w>h")
keymap.set("n", "<Right>", "<C-W>l")
keymap.set("n", "<Up>", "<C-W>k")
keymap.set("n", "<Down>", "<C-W>j")

-- Do not move my cursor when joining lines.
keymap.set("n", "J", function()
    vim.cmd([[
      normal! mzJ`z
      delmarks z
    ]])
end, {
    desc = "join line"
})

keymap.set("n", "gJ", function()
    -- we must use `normal!`, otherwise it will trigger recursive mapping
    vim.cmd([[
      normal! zmgJ`z
      delmarks z
    ]])
end, {
    desc = "join visual lines"
})

-- Break inserted text into smaller undo units when we insert some punctuation chars.
local undo_ch = {",", ".", "!", "?", ";", ":"}
for _, ch in ipairs(undo_ch) do
    keymap.set("i", ch, ch .. "<c-g>u")
end

-- insert semicolon in the end
keymap.set("i", "<A-;>", "<Esc>miA;<Esc>`ii")

-- Keep cursor position after yanking
keymap.set("n", "y", "myy")

api.nvim_create_autocmd("TextYankPost", {
    pattern = "*",
    group = api.nvim_create_augroup("restore_after_yank", {
        clear = true
    }),
    callback = function()
        vim.cmd([[
      silent! normal! `y
      silent! delmarks y
    ]])
    end
})