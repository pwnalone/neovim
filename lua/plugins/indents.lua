return {
  {
    "lukas-reineke/indent-blankline.nvim",
    version = "*",
    event = "User FileOpened",
    main = "ibl",
    opts = {
      indent = {
        char = "│",
        tab_char = "│",
      },
      scope = {
        enabled = false,
      },
      exclude = {
        -- TODO: Factor this out into a util variable...
        filetypes = {
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
        },
      },
    },
  },

  {
    "echasnovski/mini.indentscope",
    version = "*",
    event = "User FileOpened",
    opts = {
      options = { try_as_border = true },
      symbol = "│",
    },
    init = function()
      vim.api.nvim_create_autocmd("FileType", {
        -- TODO: Factor this out into a util variable...
        pattern = {
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
        },
        callback = function()
          ---@diagnostic disable-next-line: inject-field
          vim.b.miniindentscope_disable = true
        end,
      })
    end,
  },
}
