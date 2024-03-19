return {
  {
    "folke/which-key.nvim",
    event = "VeryLazy",
    opts = {},
    config = function(_, opts)
      local wk = require("which-key")

      wk.setup(opts)

      wk.register({
        ["<Leader>b"] = { name = "Buffer" },
        ["<Leader>f"] = { name = "Find" },
        ["<Leader>g"] = { name = "Git" },
        ["<Leader>l"] = { name = "LSP" },
        ["<Leader>s"] = { name = "Search" },
      })
    end,
  },
}
