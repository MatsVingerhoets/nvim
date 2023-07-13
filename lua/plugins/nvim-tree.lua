return {
  "nvim-tree/nvim-tree.lua",
  version = "*",
  lazy = false,
  dependencies = {
    "nvim-tree/nvim-web-devicons",
  },
  config = function()
    require("nvim-tree").setup({
      diagnostics = {
        enable = true,
        icons = { hint = "H", info = "I", warning = "W", error = "E" },
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
            folder_arrow = true,
          },
        },
      },
    })
  end,
}
