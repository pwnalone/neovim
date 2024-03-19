return {
  {
    "akinsho/toggleterm.nvim",
    keys = {
      {
        [[<M-'>]],
        "<Cmd>ToggleTerm direction=float<CR>",
        desc = "Toggle floating terminal",
        mode = { "n", "t", "v" },
      },
      {
        [[<M-\>]],
        "<Cmd>ToggleTerm size=15 direction=horizontal<CR>",
        desc = "Toggle horizontal terminal",
        mode = { "n", "t", "v" },
      },
      {
        [[<M-|>]],
        "<Cmd>ToggleTerm size=80 direction=vertical<CR>",
        desc = "Toggle vertical terminal",
        mode = { "n", "t", "v" },
      },
    },
    cmd = "ToggleTerm",
    opts = {
      shading_factor = -10,
      float_opts = { border = "rounded" },
      highlights = {
        NormalFloat = { link = "NormalFloat" },
        FloatBorder = { link = "FloatBorder" },
      },
    },
  },
}
