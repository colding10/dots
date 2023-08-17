local keymap = vim.keymap.set
local api = vim.api
local uv = vim.loop

local sopts = {
    silent = true
}

-- Buffer navigation
keymap("n", "<leader>1", ":BufferLineGoToBuffer 1<CR>", sopts)
keymap("n", "<leader>2", ":BufferLineGoToBuffer 2<CR>", sopts)
keymap("n", "<leader>3", ":BufferLineGoToBuffer 3<CR>", sopts)
keymap("n", "<leader>4", ":BufferLineGoToBuffer 4<CR>", sopts)
keymap("n", "<leader>5", ":BufferLineGoToBuffer 5<CR>", sopts)
keymap("n", "<leader>6", ":BufferLineGoToBuffer 6<CR>", sopts)
keymap("n", "<leader>7", ":BufferLineGoToBuffer 7<CR>", sopts)
keymap("n", "<leader>8", ":BufferLineGoToBuffer 8<CR>", sopts)
keymap("n", "<leader>9", ":BufferLineGoToBuffer 9<CR>", sopts)

keymap({"n"}, "<A-S-F>", "<cmd>lua vim.lsp.buf.format()<CR>", {
    silent = true
})

keymap({"n", "i"}, "<F5>", "<cmd>ToggleTerm direction=float<CR>", {
    silent = true
})

-- Saves the file if modified and quit
keymap("n", "<leader>q", "<cmd>x<cr>", {
    silent = true,
    desc = "quit current window"
})

-- Quit all opened buffers
keymap("n", "<leader>Q", "<cmd>qa!<cr>", {
    silent = true,
    desc = "quit nvim"
})

-- Insert a blank line below or above current line (do not move the cursor),
keymap("n", "<space>o", "printf('m`%so<ESC>``', v:count1)", {
    expr = true,
    desc = "insert line below"
})
keymap("n", "<space>O", "printf('m`%sO<ESC>``', v:count1)", {
    expr = true,
    desc = "insert line above"
})

-- Go to start or end of line easier
keymap({"n", "x"}, "H", "^")
keymap({"n", "x"}, "L", "g_")

-- Continuous visual shifting (does not exit Visual mode), `gv` means
-- to reselect previous visual area, see https://superuser.com/q/310417/736190
keymap("x", "<", "<gv")
keymap("x", ">", ">gv")

-- Change current working directory locally and print cwd after that,
keymap("n", "<leader>cd", "<cmd>lcd %:p:h<cr><cmd>pwd<cr>", {
    desc = "change cwd"
})

-- Change text without putting it into the vim register,
-- see https://stackoverflow.com/q/54255/6064933
keymap("n", "c", '"_c')
keymap("n", "C", '"_C')
keymap("n", "cc", '"_cc')
keymap("x", "c", '"_c')

-- Copy entire buffer.
keymap("n", "<leader>y", "<cmd>%yank<cr>", {
    desc = "yank entire buffer"
})


-- Switch windows
keymap("n", "<left>", "<c-w>h")
keymap("n", "<Right>", "<C-W>l")
keymap("n", "<Up>", "<C-W>k")
keymap("n", "<Down>", "<C-W>j")

-- Break inserted text into smaller undo units when we insert some punctuation chars.
local undo_ch = {",", ".", "!", "?", ";", ":"}
for _, ch in ipairs(undo_ch) do
    keymap("i", ch, ch .. "<c-g>u")
end

-- Keep cursor position after yanking
keymap("n", "y", "myy")
