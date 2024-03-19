local file_opened = vim.api.nvim_create_augroup("file_opened", {})
local term_opened = vim.api.nvim_create_augroup("term_opened", {})
local text_yanked = vim.api.nvim_create_augroup("text_yanked", {})

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

-- Return to the last cursor position when a file is opened.
vim.api.nvim_create_autocmd("BufReadPost", {
  desc = "Return to last cursor position",
  group = file_opened,
  callback = function()
    local lastpos = vim.fn.getpos([['"]])
    if lastpos[2] > 0 and lastpos[2] <= vim.fn.line("$") then
      vim.fn.setpos(".", lastpos)
      -- FIXME: This does not seem to work...
      vim.cmd("normal zv")
      vim.cmd("normal zz")
    end
  end,
})

-- Automatically start terminals in insert mode.
vim.api.nvim_create_autocmd("TermOpen", {
  desc = "Start terminal in insert mode",
  group = term_opened,
  command = "startinsert | set winfixheight",
})

-- Highlight text when it is yanked.
vim.api.nvim_create_autocmd("TextYankPost", {
  desc = "Briefly highlight yanked text",
  group = text_yanked,
  callback = function()
    vim.highlight.on_yank({ timeout = 200 })
  end,
})
