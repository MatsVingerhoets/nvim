local map = vim.api.nvim_set_keymap
local options = { noremap = true }

-- LEADER
map("", "<Space>", "<Nop>", options)
vim.g.mapleader = " "

-- RELOAD CONFIG TODO: find better way to do this with init.lua
map('n', '<leader>rl', ':source $MYVIMRC<cr>', options)

-- TABS
map('n', 'tn', ':tabnew<cr>', options)
map('n', 'tc', ':tabclose<cr>', options)
map('n', 'ts', ':tab split<cr>', options)
for index = 1, 9, 1 do map('n', 't'..index, index..'gt<cr>', options) end

-- BUFFERS
map('n', '<leader>bl', ':bnext<cr>', options)
map('n', '<leader>bj', ':bprevious<cr>', options)

-- Better window navigation
map('n', '<c-j>', "<c-w>j", options)
map('n', '<c-h>', "<c-w>h", options)
map('n', '<c-k>', "<c-w>k", options)
map('n', '<c-l>', "<c-w>l", options)

-- COPY TO CLIPBOARD
map('n', '<leader>cfr', ':let @+ = expand("%")<cr>', options)
map('n', '<leader>cff', ':let @+ = expand("%:p")<cr>', options)
map('n', '<leader>cfn', ':let @+ = expand("%:t")<cr>', options)

-- Better escape using jk in insert and terminal mode
map("i", "jk", "<ESC>", options)
map("t", "jk", "<C-\\><C-n>", options)

-- LAZYGIT
-- function _G.open_lazygit()
--   vim.cmd ':tabnew'
--   vim.cmd ':terminal lazygit'
-- end
-- map('n', '<leader>lg', ':lua open_lazygit()<cr>', options)
