return {
  { "nvim-neotest/neotest-plenary" },
  { "nvim-neotest/neotest-vim-test" },
  {
    "nvim-neotest/neotest",
    opts = { adapters = { "neotest-plenary", "neotest-vim-test" } },
  },
}
