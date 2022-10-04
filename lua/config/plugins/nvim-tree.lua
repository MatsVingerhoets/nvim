require("nvim-tree").setup({
  diagnostics = {
    enable = true,
    icons = { hint = "H", info ="I", warning = "W", error= "E" }
  },
  update_focused_file = {
    enable = true,
    update_cwd = false,
    ignore_list = {},
  },
  disable_netrw = false,
  view = {
    adaptive_size = true,
  },
  renderer = {
    highlight_git = true,
    icons = {
      show = {
        git = false,
        folder = false,
        file = false,
        folder_arrow = true 
      }
    }
  }
})

vim.api.nvim_set_keymap("n", "<C-e>", ":NvimTreeToggle<CR>", { noremap = true, silent = true })
vim.api.nvim_set_keymap("n", "<leader>n", ":NvimTreeFindFile<CR>", { noremap = true, silent = true })
