-- The leader key must be set _before_ setting up lazy.nvim.
vim.g.mapleader = " "
vim.g.maplocalleader = " "

-- Fetch / install lazy.nvim if it is not already installed.
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
  -- stylua: ignore
  vim.fn.system({ "git", "clone", "--filter=blob:none", "https://github.com/folke/lazy.nvim.git", "--branch=stable", lazypath })
end
vim.opt.rtp:prepend(lazypath)

-- Setup lazy.nvim and install plugins.
require("lazy").setup({
  -- stylua: ignore start
  spec        = "plugins",
  defaults    = { lazy = true },
  install     = { colorscheme = { "tokyonight", "habamax" } },
  ui          = { border = "rounded", title = " Plugins " },
  checker     = { enabled = true, notify = false, frequency = 24 * 3600 },
  performance = {
    rtp = {
      disabled_plugins = {
        "netrwPlugin",
        "tutor",

        -- "2html_plugin",
        -- "bugreport",
        -- "compiler",
        -- "ftplugin",
        -- "getscript",
        -- "getscriptPlugin",
        -- "gzip",
        -- "logipat",
        -- "matchit",
        -- "matchparen",
        -- "netrw",
        -- "netrwFileHandlers",
        -- "netrwSettings",
        -- "optwin",
        -- "rplugin",
        -- "rrhelper",
        -- "spellfile_plugin",
        -- "synmenu",
        -- "syntax",
        -- "tar",
        -- "tarPlugin",
        -- "tohtml",
        -- "vimball",
        -- "vimballPlugin",
        -- "zip",
        -- "zipPlugin",
      },
    },
  },
})
