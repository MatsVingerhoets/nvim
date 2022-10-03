local fn = vim.fn

-- Automatically install packer
local install_path = fn.stdpath "data" .. "/site/pack/packer/start/packer.nvim"
if fn.empty(fn.glob(install_path)) > 0 then
  PACKER_BOOTSTRAP = fn.system {
    "git",
    "clone",
    "--depth",
    "1",
    "https://github.com/wbthomason/packer.nvim",
    install_path,
  }
  print "Installing packer close and reopen Neovim..."
  vim.cmd [[packadd packer.nvim]]
end

-- Autocommand that reloads neovim whenever you save the plugins.lua file
vim.cmd [[
  augroup packer_user_config
    autocmd!
    autocmd BufWritePost init.lua source <afile> | PackerSync
  augroup end
]]

-- Use a protected call so we don't error out on first use
local status_ok, packer = pcall(require, "packer")
if not status_ok then
  return
end

-- Have packer use a popup window
packer.init {
  display = {
    open_fn = function()
      return require("packer.util").float { border = "rounded" }
    end,
  },
}

local use = require("packer").use
require('packer').startup(function() 
  -- Packer can manage itself
  use ('wbthomason/packer.nvim')

  use "nvim-lua/popup.nvim" -- An implementation of the popup api from vim in neovim
  use "nvim-lua/plenary.nvim" -- useful lua functions used by lors of plugins 
  use "folke/which-key.nvim" 
  use "windwp/nvim-autopairs"
  use "numToStr/Comment.nvim"
  use {"akinsho/toggleterm.nvim", tag = 'v1.*', config = function()
    require("toggleterm").setup()
  end} 
  -- use "akinsho/bufferline.nvim"

  -- cmp plugins
  use "hrsh7th/nvim-cmp" -- The completion plugin
  use "hrsh7th/cmp-buffer" -- buffer completions
  use "hrsh7th/cmp-path" -- path completions
  use "hrsh7th/cmp-cmdline" -- cmdline completions
  use "saadparwaiz1/cmp_luasnip" -- snippet completions
  use "hrsh7th/cmp-nvim-lsp"
  use "hrsh7th/cmp-nvim-lua"

  -- LSP
  use "neovim/nvim-lspconfig" -- enable LSP
  use "williamboman/nvim-lsp-installer" -- language server installer
  use "jose-elias-alvarez/null-ls.nvim" -- for formatters and linters

  -- snippets
  use "L3MON4D3/LuaSnip" --snippet engine
  use "rafamadriz/friendly-snippets" -- a bunch of snippets to use

  -- Colorschemes
  use "lunarvim/colorschemes"

  use ('machakann/vim-sandwich')   -- sandwich

  -- Nvim tree
  use ({
    'kyazdani42/nvim-tree.lua',
    requires = 'kyazdani42/nvim-web-devicons',
  })

  -- Treesitter
  use {
    "nvim-treesitter/nvim-treesitter",
    run = ":TSUpdate",
  }  
  use "nvim-treesitter/playground"
  use "windwp/nvim-ts-autotag"
  use "JoosepAlviste/nvim-ts-context-commentstring"

  -- git
  use 'f-person/git-blame.nvim'

  -- Telescope
  use "nvim-telescope/telescope.nvim"
  use 'nvim-telescope/telescope-media-files.nvim'
  use {'nvim-telescope/telescope-fzf-native.nvim', run = 'make' }
  -- Automatically set up your configuration after cloning packer.nvim
  -- Put this at the end after all plugins  
  if PACKER_BOOTSTRAP then
    require("packer").sync()
  end
end)

require("config.plugins.nvim-tree")
require("config.plugins.cmp")
require("config.plugins.colorscheme")
require("config.plugins.treesitter")
require("config.plugins.whichkey")
require("config.plugins.telescope")
require("config.plugins.autopairs")
require("config.plugins.comment")
require("config.plugins.bufferline")
require("config.plugins.toggleterm")
