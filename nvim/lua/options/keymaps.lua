local keymap = vim.keymap
local api = vim.api
local uv = vim.loop

local sopts = {
    silent = true
}

-- Buffer navigation
keymap.set("n", "<leader>1", ":BufferLineGoToBuffer 1<CR>", sopts)
keymap.set("n", "<leader>2", ":BufferLineGoToBuffer 2<CR>", sopts)
keymap.set("n", "<leader>3", ":BufferLineGoToBuffer 3<CR>", sopts)
keymap.set("n", "<leader>4", ":BufferLineGoToBuffer 4<CR>", sopts)
keymap.set("n", "<leader>5", ":BufferLineGoToBuffer 5<CR>", sopts)
keymap.set("n", "<leader>6", ":BufferLineGoToBuffer 6<CR>", sopts)
keymap.set("n", "<leader>7", ":BufferLineGoToBuffer 7<CR>", sopts)
keymap.set("n", "<leader>8", ":BufferLineGoToBuffer 8<CR>", sopts)
keymap.set("n", "<leader>9", ":BufferLineGoToBuffer 9<CR>", sopts)

keymap.set({"n"}, "Ï", "<cmd>lua vim.lsp.buf.format()<CR>", {
    silent = true
})

keymap.set({"n", "i"}, "<F5>", "<cmd>ToggleTerm direction=float<CR>", {
    silent = true
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

-- Go to start or end of line easier
keymap.set({"n", "x"}, "H", "^")
keymap.set({"n", "x"}, "L", "g_")

-- Continuous visual shifting (does not exit Visual mode), `gv` means
-- to reselect previous visual area, see https://superuser.com/q/310417/736190
keymap.set("x", "<", "<gv")
keymap.set("x", ">", ">gv")

-- Change current working directory locally and print cwd after that,
-- see https://vim.fandom.com/wiki/Set_working_directory_to_the_current_file
keymap.set("n", "<leader>cd", "<cmd>lcd %:p:h<cr><cmd>pwd<cr>", {
    desc = "change cwd"
})

-- Change text without putting it into the vim register,
-- see https://stackoverflow.com/q/54255/6064933
keymap.set("n", "c", '"_c')
keymap.set("n", "C", '"_C')
keymap.set("n", "cc", '"_cc')
keymap.set("x", "c", '"_c')

-- Copy entire buffer.
keymap.set("n", "<leader>y", "<cmd>%yank<cr>", {
    desc = "yank entire buffer"
})

-- Switch windows
keymap.set("n", "<left>", "<c-w>h")
keymap.set("n", "<Right>", "<C-W>l")
keymap.set("n", "<Up>", "<C-W>k")
keymap.set("n", "<Down>", "<C-W>j")

-- Break inserted text into smaller undo units when we insert some punctuation chars.
local undo_ch = {",", ".", "!", "?", ";", ":"}
for _, ch in ipairs(undo_ch) do
    keymap.set("i", ch, ch .. "<c-g>u")
end

-- insert semicolon in the end
keymap.set("i", "<A-;>", "<Esc>miA;<Esc>`ii")

-- Keep cursor position after yanking
keymap.set("n", "y", "myy")
