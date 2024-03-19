return {
  {
    "akinsho/bufferline.nvim",
    version = "*",
    dependencies = { "nvim-tree/nvim-web-devicons" },
    event = "BufEnter",
    keys = {
      { "<Leader>bA", "<Cmd>BufferLineCloseOthers<CR>", desc = "Close all buffers except this one" },
      { "<Leader>bC", "<Cmd>BufferLinePickClose<CR>", desc = "Choose buffer to close" },
      { "<Leader>bL", "<Cmd>BufferLineCloseLeft<CR>", desc = "Close all buffers to the left" },
      { "<Leader>bR", "<Cmd>BufferLineCloseRight<CR>", desc = "Close all buffers to the right" },
      { "<Leader>bU", "<Cmd>BufferLineGroupClose ungrouped<CR>", desc = "Close non-pinned buffers" },
      { "<Leader>bb", "<Cmd>BufferLineTogglePin<CR>", desc = "Toggle buffer pin" },
      { "<Leader>bc", "<Cmd>BufferLinePick<CR>", desc = "Choose buffer" },
      { "<Leader>bn", "<Cmd>BufferLineCycleNext<CR>", desc = "Go to next buffer (same as L)" },
      { "<Leader>bp", "<Cmd>BufferLineCyclePrev<CR>", desc = "Go to prev buffer (same as H)" },
      { "<Leader>b>", "<Cmd>BufferLineMoveNext<CR>", desc = "Move buffer right (same as <C-l>)" },
      { "<Leader>b<", "<Cmd>BufferLineMovePrev<CR>", desc = "Move buffer left (same as <C-h>)" },
      {
        "<Leader>b0",
        function()
          require("bufferline").move_to(1)
        end,
        desc = "Move buffer to beginning",
      },
      {
        "<Leader>b$",
        function()
          require("bufferline").move_to(-1)
        end,
        desc = "Move buffer to end",
      },
      { "<C-h>", "<Cmd>BufferLineMovePrev<CR>", desc = "Move buffer to the left" },
      { "<C-l>", "<Cmd>BufferLineMoveNext<CR>", desc = "Move buffer to the right" },
      { "H", "<Cmd>BufferLineCyclePrev<CR>", desc = "Go to prev buffer" },
      { "L", "<Cmd>BufferLineCycleNext<CR>", desc = "Go to next buffer" },
    },
    opts = {
      options = {
        diagnostics = "nvim_lsp",
        diagnostics_update_in_insert = false,
        always_show_bufferline = true,
        separator_style = "thick",
        offsets = {
          {
            filetype = "neo-tree",
            text = "Neotree",
            text_align = "center",
            highlight = "Directory",
          },
        },
        move_wraps_at_ends = true,
        hover = {
          enabled = true,
          delay = 100,
          reveal = { "close" },
        },
      },
    },
  },
}
