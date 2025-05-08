-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here
vim.keymap.set("n", "<leader>w", "<cmd>w!<CR>", { desc = "Save", remap = true })
vim.keymap.set("n", "<leader>F", "<cmd>FzfLua live_grep theme=ivy<cr>", { desc = "Find text", noremap = true })
vim.keymap.set("n", "<leader>e", ":NvimTreeToggle<CR>", { noremap = true, silent = true })
vim.keymap.set("n", "<leader>n", ":NvimTreeFindFile<CR>", { noremap = true, silent = true })
vim.keymap.set("n", "<leader>gg", ":LazyGit<CR>", { noremap = true, silent = true })
vim.keymap.set("n", "<leader>ww", ":noa w<CR>", { noremap = true, silent = true })
vim.keymap.set("v", "p", "P", { desc = "paste without yank", remap = true })

-- Define a function to open a new tab, split vertically, and open terminals
function OpenVerticalTerminals()
  vim.cmd("tabnew")
  vim.cmd("vsplit")
  vim.cmd("terminal")
  vim.cmd("wincmd h")
  vim.cmd("terminal")
end
vim.api.nvim_set_keymap("n", "<leader>tg", ":lua OpenVerticalTerminals()<CR>", { noremap = true, silent = true })

function _G.set_terminal_keymaps()
  local opts = { buffer = 0 }
  vim.keymap.set("t", "<esc>", [[<C-\><C-n>]], opts)
  vim.keymap.set("t", "jk", [[<C-\><C-n>]], opts)
  vim.keymap.set("t", "<C-h>", [[<Cmd>wincmd h<CR>]], opts)
  vim.keymap.set("t", "<C-j>", [[<Cmd>wincmd j<CR>]], opts)
  vim.keymap.set("t", "<C-k>", [[<Cmd>wincmd k<CR>]], opts)
  vim.keymap.set("t", "<C-l>", [[<Cmd>wincmd l<CR>]], opts)
  vim.keymap.set("t", "<C-w>", [[<C-\><C-n><C-w>]], opts)
end
-- if you only want these mappings for toggle term use term://*toggleterm#* instead
vim.cmd("autocmd! TermOpen term://* lua set_terminal_keymaps()")
local Terminal = require("toggleterm.terminal").Terminal
local float_term = Terminal:new({
  direction = "float",
  on_open = function(term)
    vim.cmd("startinsert!")
    vim.api.nvim_buf_set_keymap(
      term.bufnr,
      "n",
      "<m-1>",
      "<cmd>1ToggleTerm direction=float<cr>",
      { noremap = true, silent = true }
    )
    vim.api.nvim_buf_set_keymap(
      term.bufnr,
      "t",
      "<m-1>",
      "<cmd>1ToggleTerm direction=float<cr>",
      { noremap = true, silent = true }
    )
    vim.api.nvim_buf_set_keymap(
      term.bufnr,
      "i",
      "<m-1>",
      "<cmd>1ToggleTerm direction=float<cr>",
      { noremap = true, silent = true }
    )
    vim.api.nvim_buf_set_keymap(term.bufnr, "", "<m-2>", "<nop>", { noremap = true, silent = true })
    vim.api.nvim_buf_set_keymap(term.bufnr, "", "<m-3>", "<nop>", { noremap = true, silent = true })
  end,
  count = 1,
})

function _FLOAT_TERM()
  float_term:toggle()
end

vim.api.nvim_set_keymap("n", "<m-1>", "<cmd>lua _FLOAT_TERM()<CR>", { noremap = true, silent = true })
vim.api.nvim_set_keymap("i", "<m-1>", "<cmd>lua _FLOAT_TERM()<CR>", { noremap = true, silent = true })
