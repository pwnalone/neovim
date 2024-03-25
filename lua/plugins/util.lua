return {
  -- Enhanced interface for viewing Git diffs / merging / resolving conflicts.
  {
    "sindrets/diffview.nvim",
    version = false,
    dependencies = { "nvim-web-devicons" },
    cmd = {
      "DiffviewOpen",
      "DiffviewFileHistory",
      "DiffviewFocusFiles",
      "DiffviewToggleFiles",
    },
    keys = {
      { "<Leader>gdc", "<Cmd>DiffviewClose<CR>", desc = "Close diff view" },
      { "<Leader>gdd", "<Cmd>DiffviewOpen<CR>", desc = "Open diff view" },
      { "<Leader>gdD", "<Cmd>DiffviewOpen -uno -- %<CR>", desc = "Open diff view (current file)" },
      { "<Leader>gdu", "<Cmd>DiffviewOpen -uno<CR>", desc = "Open diff view (no untracked)" },
      { "<Leader>gdh", "<Cmd>DiffviewFileHistory<CR>", desc = "Open file history diff view", mode = { "n", "x" } },
      { "<Leader>gdH", "<Cmd>DiffviewFileHistory %<CR>", desc = "Open file history diff view (current file)" },
      { "<Leader>gds", "<Cmd>DiffviewFileHistory -g --range=stash<CR>", desc = "Open diffs of Git stashes" },
      { "<Leader>gdr", "<Cmd>DiffviewRefresh<CR>", desc = "Refresh diff view file stats" },
      { "<Leader>gdL", "<Cmd>DiffviewLog<CR>", desc = "Open diff view debug log" },
    },
    opts = function()
      local actions = require("diffview.actions")

      local view_keymaps = {
        { "n", "<leader>b", false },
        { "n", "<leader>e", actions.toggle_files, { desc = "Toggle the file panel" } },
        { "n", "<leader>o", actions.focus_files, { desc = "Bring focus to the file panel" } },
      }
      local file_keymaps = {
        { "n", "<leader>b", false },
        { "n", "<leader>e", actions.toggle_files, { desc = "Toggle the file panel" } },
        { "n", "<leader>o", actions.focus_files, { desc = "Bring focus to the file panel" } },
        { "n", "<c-d>", actions.scroll_view(0.25), { desc = "Scroll the view down" } },
        { "n", "<c-u>", actions.scroll_view(-0.25), { desc = "Scroll the view up" } },
      }

      return {
        enhanced_diff_hl = true,
        keymaps = {
          view = view_keymaps,
          file_panel = file_keymaps,
          file_history_panel = file_keymaps,
        },
      }
    end,
  },

  -- Run snippets of code for practically any language directly in the editor.
  {
    "michaelb/sniprun",
    build = "sh install.sh " .. tostring(vim.fn.executable("cargo")),
    cmd = { "SnipInfo", "SnipRun" },
    keys = {
      { "<Leader>rC", "<Plug>SnipReplMemoryClean", desc = "Clear REPL memory" },
      { "<Leader>rc", "<Plug>SnipClose", desc = "Clear code snippet output" },
      { "<Leader>ri", "<Plug>SnipInfo", desc = "Sniprun info" },
      { "<Leader>rr", "<Plug>SnipRun", desc = "Run code snippet", mode = { "n", "x" } },
      { "<Leader>rs", "<Plug>SnipReset", desc = "Stop running code snippet" },
      { "gx", "<Plug>SnipRunOperator", desc = "Run code snippet" },
    },
    opts = {
      selected_interpreters = vim.fn.executable("lua") ~= 1 and { "Lua_nvim" } or {},
      display = { "NvimNotify", "VirtualTextOk" },
      -- stylua: ignore
      snipruncolors = {
        SniprunVirtualTextOk  = { link = "DiagnosticVirtualTextInfo" },
        SniprunVirtualTextErr = { link = "DiagnosticVirtualTextError" },
        SniprunFloatingWinOk  = { link = "NotifyINFOTitle" },
        SniprunFloatingWinErr = { link = "NotifyERRORTitle" },
      },
    },
  },
}
