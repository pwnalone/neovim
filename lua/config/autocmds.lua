local file_opened = vim.api.nvim_create_augroup("file_opened", {})

-- Trigger the 'User FileOpened' event when a file is opened.
vim.api.nvim_create_autocmd({ "BufNewFile", "BufReadPost", "BufWritePre" }, {
  desc = "Trigger 'User FileOpened' event",
  group = file_opened,
  callback = function(event)
    local buftype = vim.api.nvim_buf_get_option(event.buf, "buftype")
    if event.file ~= "" and buftype ~= "nofile" then
      --
      -- PERF:
      --
      -- This should probably be wrapped in a call to `vim.schedule()`, but doing so
      -- prevents an LSP server from attaching to the buffer for some reason.
      --
      -- TODO:
      --
      -- Figure out what is the issue and fix it...
      --
      vim.api.nvim_exec_autocmds("User", {
        pattern = "FileOpened",
        modeline = false,
      })
    end
  end,
})
