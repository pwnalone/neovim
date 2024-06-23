local Util = require("util.common")

return {
  -- Automatically install missing Treesitter parsers.
  {
    "nvim-treesitter/nvim-treesitter",
    cmd = { "TSInstallAll" },
    opts = function(_, opts)
      opts.ensure_installed = Util.tbl_dedup(opts.ensure_installed)

      -- Create a user command to synchronously install all parsers in `opts.ensure_installed`.
      vim.api.nvim_create_user_command("TSInstallAll", function()
        vim.cmd("TSInstallSync " .. table.concat(opts.ensure_installed, " "))
      end, {})

      return vim.tbl_extend("force", opts, { auto_install = true })
    end,
  },
}
