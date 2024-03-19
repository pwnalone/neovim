-- stylua: ignore start
vim.opt.clipboard      = "unnamed"  -- To PRIMARY selection
vim.opt.colorcolumn    = "+0"
vim.opt.conceallevel   = 0
vim.opt.cursorline     = true
vim.opt.expandtab      = true
vim.opt.hidden         = true
vim.opt.hlsearch       = true
vim.opt.ignorecase     = true
vim.opt.incsearch      = true
vim.opt.mouse          = "a"
vim.opt.nrformats      = { "alpha", "octal", "hex", "bin" }
vim.opt.number         = true
vim.opt.numberwidth    = 4
vim.opt.relativenumber = true
vim.opt.scrolloff      = 8
vim.opt.shiftwidth     = 2
vim.opt.sidescrolloff  = 8
vim.opt.signcolumn     = "yes"
vim.opt.smartcase      = true
vim.opt.splitbelow     = true
vim.opt.splitright     = true
vim.opt.swapfile       = false
vim.opt.tabstop        = 2
vim.opt.termguicolors  = true
vim.opt.textwidth      = 100
vim.opt.undodir        = vim.fn.stdpath("cache") .. "/undo"
vim.opt.undofile       = true
vim.opt.updatetime     = 100
vim.opt.whichwrap      = "b,s,h,l,<,>,[,]"
vim.opt.wrap           = false
-- stylua: ignore end

vim.opt.iskeyword:append("-")

vim.opt.sessionoptions:append("globals")
vim.opt.sessionoptions:append("options")
