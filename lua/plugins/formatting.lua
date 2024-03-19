local format_options = { lsp_fallback = true, timeout_ms = 500 }

return {
  {
    "stevearc/conform.nvim",
    event = "BufWritePre",
    cmd = "ConformInfo",
    keys = {
      {
        "gq",
        function()
          require("conform").format(format_options)
        end,
        desc = "Format current buffer",
        mode = { "n", "v" },
      },
    },
    opts = {
      format_on_save = format_options,
      formatters_by_ft = {
        lua = { "stylua" },
      },
    },
  },
}
