local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
  -- stylua: ignore
  vim.fn.system({ "git", "clone", "--filter=blob:none", "https://github.com/folke/lazy.nvim.git", "--branch=stable", lazypath })
end
vim.opt.rtp:prepend(vim.env.LAZY or lazypath)

require("lazy").setup({
  spec = {
    { "LazyVim/LazyVim", import = "lazyvim.plugins" },
    -- { import = "lazyvim.plugins.extras.lang.typescript" },
    -- { import = "lazyvim.plugins.extras.lang.json" },
    -- { import = "lazyvim.plugins.extras.ui.mini-animate" },
    { import = "plugins" },
  },
  -- stylua: ignore start
  defaults         = { lazy = true, version = false },
  install          = { colorscheme = { "tokyonight", "habamax" } },
  ui               = { border = "rounded", title = " Plugins " },
  checker          = { enabled = true, notify = false, frequency = 24 * 3600 },
  change_detection = { enabled = true, notify = false },
  performance      = {
    rtp = {
      disabled_plugins = {
        "tutor",

        -- "gzip",
        -- "matchit",
        -- "matchparen",
        -- "netrwPlugin",
        -- "tarPlugin",
        -- "tohtml",
        -- "zipPlugin",
      },
    },
  },
})
