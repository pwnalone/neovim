return {
  {
    "nvim-lualine/lualine.nvim",
    dependencies = { "nvim-tree/nvim-web-devicons" },
    event = "VeryLazy",
    init = function()
      -- Prevent the statusline from flashing on the starter page.
      vim.g.lualine_laststatus = vim.o.laststatus
      if vim.fn.argc(-1) < 1 then
        vim.o.laststatus = 0
      end
    end,
    config = function(_, opts)
      vim.o.laststatus = vim.g.lualine_laststatus
      require("lualine").setup(opts)
    end,
    opts = {
      options = {
        globalstatus = true,
        disabled_filetypes = {
          statusline = { "alpha", "dashboard", "starter" },
        },
        ignore_focus = { "neo-tree" },
      },
    },
  },
}
