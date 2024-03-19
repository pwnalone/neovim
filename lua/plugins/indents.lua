local ignored_filetypes = {
  "Trouble",
  "alpha",
  "dashboard",
  "help",
  "lazy",
  "lazyterm",
  "mason",
  "neo-tree",
  "notify",
  "toggleterm",
  "trouble",
}

return {
  {
    "lukas-reineke/indent-blankline.nvim",
    event = "User FileOpened",
    main = "ibl",
    opts = {
      exclude = {
        filetypes = ignored_filetypes,
      },
      indent = {
        char = "│",
        tab_char = "│",
      },
      scope = {
        enabled = false,
      },
    },
  },

  {
    "echasnovski/mini.indentscope",
    event = "User FileOpened",
    opts = {
      options = { try_as_border = true },
      symbol = "│",
    },
    init = function()
      vim.api.nvim_create_autocmd("FileType", {
        pattern = ignored_filetypes,
        callback = function()
          ---@diagnostic disable-next-line: inject-field
          vim.b.miniindentscope_disable = true
        end,
      })
    end,
  },
}
