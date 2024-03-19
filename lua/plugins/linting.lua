local lint = function()
  require("lint").try_lint()
end

return {
  "mfussenegger/nvim-lint",
  version = false,
  event = "User FileOpened",
  keys = { { "<Leader>ll", lint, desc = "Lint current buffer" } },
  config = function()
    require("lint").linters_by_ft = {}
    vim.api.nvim_create_autocmd({ "BufEnter", "BufWritePost", "InsertLeave" }, {
      desc = "Lint current buffer",
      group = vim.api.nvim_create_augroup("linting", {}),
      callback = lint,
      buffer = 0,
    })
  end,
}
