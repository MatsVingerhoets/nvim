local set = vim.opt
local cmd = vim.cmd

-- change split directions
set.splitright = true
set.splitbelow = true

-- hide current mode
set.showmode = false
set.showcmd = false

-- set termgui colors
set.termguicolors = true

set.expandtab = true
set.tabstop = 2
set.shiftwidth = 2
set.autoindent = true

-- line wrapping
set.wrap = false
set.signcolumn = "yes"

-- search settings
set.ignorecase = true
set.smartcase = true

-- show line numbers, except in terminal
set.number = true
set.relativenumber = true
cmd("au TermOpen * setlocal nonumber norelativenumber")

-- time to wait for a mapped sequence to complete (in milliseconds)
set.timeoutlen =
	250,
	
	-- sees test-test as one word
set.iskeyword:append("-")

-- highlight cursorline
set.cursorline = true

-- allow hidden buffers
set.hidden = true

-- match os clipboard with nvim
set.clipboard = { "unnamed", "unnamedplus" }
set.inccommand = "split"

-- highlight on yank
cmd("au TextYankPost * silent! lua vim.highlight.on_yank()")

-- set to auto read when a file is changed from the outside
set.autoread = true
cmd("au focusgained,bufenter * checktime")

-- removes bottom bars
vim.o.ls = 0
vim.o.ch = 0

-- Set winbar on top
--[[ vim.o.winbar="%f" ]]
