local status_ok, configs = pcall(require, "nvim-treesitter.configs")
if not status_ok then
  return
end
require('nvim-ts-autotag').setup()
configs.setup {
  ensure_installed = "all",
  sync_install = false, 
  ignore_install = { "phpdoc" }, -- List of parsers to ignore installing
  highlight = {
    enable = true, -- false will disable the whole extension
    disable = { "" }, -- list of language that will be disabled
    additional_vim_regex_highlighting = true,
  },
  indent = { enable = true, disable = { "yaml" } },
  rainbow = {
      enable = true,
      extended_mode = true,
      max_file_lines = nil,
  },
  context_commentstring = {
    enable = true,
    enable_autocmd = false,
  },
} 