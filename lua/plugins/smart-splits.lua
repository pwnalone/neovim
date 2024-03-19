return {
  {
    "mrjones2014/smart-splits.nvim",
    event = "VeryLazy",
    opts = { default_amount = 1, cursor_follows_swapped_bufs = true },
    config = function(_, opts)
      local ss = require("smart-splits")

      ss.setup(opts)

      local map = function(mode, lhs, rhs, opts)
        local base = { noremap = true, silent = true }
        vim.keymap.set(mode, lhs, rhs, vim.tbl_extend("force", base, opts or {}))
      end

      -- Switch windows
      map({ "n", "i", "t" }, "<M-h>", ss.move_cursor_left, { desc = "Go to left window" })
      map({ "n", "i", "t" }, "<M-j>", ss.move_cursor_down, { desc = "Go to lower window" })
      map({ "n", "i", "t" }, "<M-k>", ss.move_cursor_up, { desc = "Go to upper window" })
      map({ "n", "i", "t" }, "<M-l>", ss.move_cursor_right, { desc = "Go to right window" })

      -- Resize windows
      map({ "n", "i", "t" }, "<M-H>", ss.resize_left, { desc = "Resize window left" })
      map({ "n", "i", "t" }, "<M-J>", ss.resize_down, { desc = "Resize window upwards" })
      map({ "n", "i", "t" }, "<M-K>", ss.resize_up, { desc = "Resize window downwards" })
      map({ "n", "i", "t" }, "<M-L>", ss.resize_right, { desc = "Resize window right" })

      -- Swap buffers between windows
      map("n", "<leader><leader>h", ss.swap_buf_left, { desc = "Swap with left window" })
      map("n", "<leader><leader>j", ss.swap_buf_down, { desc = "Swap with upper window" })
      map("n", "<leader><leader>k", ss.swap_buf_up, { desc = "Swap with lower window" })
      map("n", "<leader><leader>l", ss.swap_buf_right, { desc = "Swap with right window" })
    end,
  },
}
