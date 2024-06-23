local Util = require("util.common")

return {
  {
    "nvim-lspconfig",
    opts = {
      inlay_hints = { enabled = false },
    },
  },
  {
    "williamboman/mason.nvim",
    cmd = { "MasonInstallAll" },
    opts = function(_, opts)
      local ensure_installed = {
        "clangd",
        "codelldb",
        "debugpy",
        "lua-language-server",
        "pyright",
        "ruff-lsp",
        "rust-analyzer",
        "shfmt",
        "stylua",
        "taplo",
      }

      opts.ensure_installed = Util.tbl_dedup(vim.tbl_extend("force", opts.ensure_installed, ensure_installed))

      -- Create user command to synchronously install all Mason tools in `opts.ensure_installed`.
      vim.api.nvim_create_user_command("MasonInstallAll", function()
        for _, tool in ipairs(opts.ensure_installed) do
          vim.cmd("MasonInstall " .. tool)
        end
      end, {})

      return opts
    end,
  },
}
