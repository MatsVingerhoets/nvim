local fn = vim.fn
local global = require("config.global")

-- Automatically install packer
local install_path = fn.stdpath("data") .. "/site/pack/packer/start/packer.nvim"
if fn.empty(fn.glob(install_path)) > 0 then
	PACKER_BOOTSTRAP = fn.system({
		"git",
		"clone",
		"--depth",
		"1",
		"https://github.com/wbthomason/packer.nvim",
		install_path,
	})
	print("Installing packer close and reopen Neovim...")
	vim.cmd([[packadd packer.nvim]])
end

-- Autocommand that reloads neovim whenever you save the plugins.lua file
vim.cmd([[
  augroup packer_user_config
    autocmd!
    autocmd BufWritePost init.lua source <afile> | PackerSync
  augroup end
]])

-- Have packer use a popup window
require("packer").init({
	display = {
		open_fn = function()
			return require("packer.util").float({ border = "rounded" })
		end,
	},
})

local use = require("packer").use
require("packer").startup(function()
	-- Packer can manage itself
	use("wbthomason/packer.nvim")

	-- nvim tree
	use({
		"nvim-tree/nvim-tree.lua",
		requires = {
			"nvim-tree/nvim-web-devicons", -- optional, for file icons
		},
	})
	-- autocompletion
	use("hrsh7th/nvim-cmp")
	use("hrsh7th/cmp-buffer") -- source for text in buffer
	use("hrsh7th/cmp-path") -- source for file system paths

	-- snippets
	use("L3MON4D3/LuaSnip") -- snippet engine
	use("saadparwaiz1/cmp_luasnip") -- for autocompletion
	use("rafamadriz/friendly-snippets") -- useful snippets

	-- LSP
	use({
		"williamboman/mason.nvim",
		requires = {
			{ "williamboman/mason-lspconfig.nvim" },
			{ "neovim/nvim-lspconfig" }, -- easily configure language servers
			{ "hrsh7th/cmp-nvim-lsp" }, -- for autocompletion
			{ "glepnir/lspsaga.nvim", branch = "main" }, -- enhanced lsp uis
			{ "mfussenegger/nvim-dap" },
			{ "jose-elias-alvarez/null-ls.nvim" }, -- formatting and linting
			{ "jose-elias-alvarez/typescript.nvim" },
			{ "jayp0521/mason-null-ls.nvim" }, -- formaitting and linting
			{ "jayp0521/mason-nvim-dap.nvim" },
			{ "onsails/lspkind.nvim" }, -- vs-code like icons for autocompletion
		},
	})

	-- snippets
	use({
		"L3MON4D3/LuaSnip",
	}) -- snippet engine
	use("saadparwaiz1/cmp_luasnip") -- for autocompletion
	use("rafamadriz/friendly-snippets") -- useful snippets

	-- Lualine
	use({
		"nvim-lualine/lualine.nvim",
		requires = { "kyazdani42/nvim-web-devicons", opt = true },
	})

	-- Telescope with fuzzy finder
	use("nvim-telescope/telescope.nvim")
	use({ "nvim-telescope/telescope-fzf-native.nvim", run = "make" })

	-- Plenary a plugin that is used by a lot of plugins
	use("nvim-lua/plenary.nvim")

	-- Darkplus theme
	use("lunarvim/darkplus.nvim")

	-- Commenting with gc
	use("numToStr/Comment.nvim")

	-- Treesitter
	use({
		"nvim-treesitter/nvim-treesitter",
		run = function()
			local ts_update = require("nvim-treesitter.install").update({ with_sync = true })
			ts_update()
		end,
	})

	-- Bufferline for buffertabs
	use({ "akinsho/bufferline.nvim", tag = "v3.*", requires = "nvim-tree/nvim-web-devicons" })

	-- auto closing
	use("windwp/nvim-autopairs")
	use("windwp/nvim-ts-autotag")

	-- commentstring
	use("JoosepAlviste/nvim-ts-context-commentstring")

	-- git signs plugin
	use("lewis6991/gitsigns.nvim")

	-- better yank functionality
	use("gbprod/yanky.nvim")

	-- whichkey
	use("folke/which-key.nvim")

	-- toggleterm
	use("akinsho/toggleterm.nvim")

	-- Automatically set up your configuration after cloning packer.nvim
	-- Put this at the end after all plugins
	if PACKER_BOOTSTRAP then
		require("packer").sync()
	end
end)

require("config.plugins.nvim-cmp")
require("config.plugins.comment")
require("config.plugins.lualine")
require("config.plugins.lualine")
require("config.lsp")
require("config.plugins.nvim-tree")
require("config.plugins.autopairs")
require("config.plugins.treesitter")
require("config.plugins.gitsigns")
require("config.plugins.telescope")
require("config.plugins.yanky")
require("config.plugins.toggleterm")
require("config.plugins.whichkey")
require("config.plugins.bufferline")
