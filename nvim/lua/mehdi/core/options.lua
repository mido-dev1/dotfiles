local opt = vim.opt

vim.g.mapleader = ' '
vim.g.maplocalleader = ' '

opt.relativenumber = true
opt.nu = true
opt.termguicolors = true

-- tabs & indentation
opt.tabstop = 4
opt.shiftwidth = 4
opt.softtabstop = 4
opt.expandtab = true
opt.cursorline = true

opt.smartindent = true
-- opt.autoindent = true

opt.showmode = false
opt.smartcase = true
opt.incsearch = true

opt.splitbelow = true
opt.splitright = true

opt.swapfile = false
opt.backup = false
opt.undofile = true

opt.signcolumn = "yes"
opt.wrap = true
opt.scrolloff = 8
opt.sidescrolloff = 8

opt.updatetime = 300

vim.cmd "set whichwrap+=<,>,[,],h,l"
vim.cmd [[set iskeyword+=-]]

-- for cmp
opt.completeopt = { "menu", "menuone", "noselect" }

-- vim.cmd("set listchars= tab:▷ ,trail:·,extends:◣,precedes:◢,nbsp:○")
