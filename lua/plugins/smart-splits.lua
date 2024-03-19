return {
  {
    "mrjones2014/smart-splits.nvim",
    event = "VeryLazy",
    opts = { default_amount = 1, cursor_follows_swapped_bufs = true },
    config = function()
      local map = function(mode, lhs, rhs, opts)
        local base = { noremap = true, silent = true }
        vim.keymap.set(mode, lhs, rhs, vim.tbl_extend("force", base, opts or {}))
      end

      -- Switch windows
      map({ "n", "i", "t" }, "<M-h>", function()
        require("smart-splits").move_cursor_left()
      end, { desc = "Go to left window" })
      map({ "n", "i", "t" }, "<M-j>", function()
        require("smart-splits").move_cursor_down()
      end, { desc = "Go to lower window" })
      map({ "n", "i", "t" }, "<M-k>", function()
        require("smart-splits").move_cursor_up()
      end, { desc = "Go to upper window" })
      map({ "n", "i", "t" }, "<M-l>", function()
        require("smart-splits").move_cursor_right()
      end, { desc = "Go to right window" })

      -- Resize windows
      map({ "n", "i", "t" }, "<M-H>", function()
        require("smart-splits").resize_left()
      end, { desc = "Resize window left" })
      map({ "n", "i", "t" }, "<M-J>", function()
        require("smart-splits").resize_down()
      end, { desc = "Resize window upwards" })
      map({ "n", "i", "t" }, "<M-K>", function()
        require("smart-splits").resize_up()
      end, { desc = "Resize window downwards" })
      map({ "n", "i", "t" }, "<M-L>", function()
        require("smart-splits").resize_right()
      end, { desc = "Resize window right" })
    end,
  },
}
