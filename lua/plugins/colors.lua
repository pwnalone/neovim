-- NOTE: Both Tokyonight and Catppuccin are already installed.

return {
  -- Install Kanagawa.
  {
    "rebelot/kanagawa.nvim",
    version = false,
    lazy = true,
    opts = { theme = { "wave" } },
  },

  -- Pick colorscheme.
  { "LazyVim/LazyVim", opts = { colorscheme = "tokyonight" } },
}
