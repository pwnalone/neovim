return {
  {
    "nvim-neo-tree/neo-tree.nvim",
    branch = "v3.x",
    dependencies = {
      "nvim-lua/plenary.nvim",
      "nvim-tree/nvim-web-devicons",
      "MunifTanjim/nui.nvim",
    },
    cmd = "Neotree",
    --
    -- FIXME: These keymaps sometimes cause an error.
    --
    -- E.g. An error occurs when Neotree is open on the left and you toggle the popup or vice-versa.
    --
    keys = {
      {
        "<Leader>e",
        "<Cmd>Neotree filesystem close float<CR><Cmd>Neotree filesystem toggle left<CR>",
        desc = "Toggle file explorer",
      },
      {
        "<Leader>E",
        "<Cmd>Neotree filesystem close left<CR><Cmd>Neotree filesystem toggle float<CR>",
        desc = "Toggle file explorer (popup)",
      },
    },
    init = function()
      if vim.fn.argc(-1) == 1 then
        ---@diagnostic disable-next-line: param-type-mismatch
        local stat = vim.loop.fs_stat(vim.fn.argv(0))
        if stat and stat.type == "directory" then
          require("neo-tree")
        end
      end
    end,
    opts = {
      sources = { "filesystem", "buffers", "git_status", "document_symbols" },
      window = {
        mappings = {
          ["<space>"] = "none",
        },
      },
      filesystem = {
        use_libuv_file_watcher = true,
        follow_current_file = {
          enabled = true,
        },
      },
      buffers = {
        follow_current_file = {
          enabled = true,
        },
      },
    },
  },
}
