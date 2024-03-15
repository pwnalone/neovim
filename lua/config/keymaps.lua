local map = function(mode, lhs, rhs, opts)
  local base = { noremap = true, silent = true }
  vim.keymap.set(mode, lhs, rhs, vim.tbl_extend("force", base, opts or {}))
end

local del = function(mode, lhs, buffer)
  vim.keymap.del(mode, lhs, { buffer = buffer })
end

-- Disable some default mappings
del({ "n", "i", "v" }, "<M-j>")
del({ "n", "i", "v" }, "<M-k>")

del({ "n", "t" }, "<C-/>")
del({ "n", "t" }, "<C-_>")
del({ "n", "t" }, "<C-h>")
del({ "n", "t" }, "<C-j>")
del({ "n", "t" }, "<C-k>")
del({ "n", "t" }, "<C-l>")

del("n", "<C-Left>")
del("n", "<C-Down>")
del("n", "<C-Up>")
del("n", "<C-Right>")

-- Enter command mode more easily
map({ "n", "v" }, ";", ":", { desc = "Enter command mode", silent = false })

-- Increment/decrement numbers, letters, etc.
map({ "n", "v" }, "+", "<C-a>", { desc = "Increment number or selection" })
map({ "n", "v" }, "-", "<C-a>", { desc = "Decrement number or selection" })
map("v", "g+", "g<C-a>", { desc = "Progressively increment selections" })
map("v", "g-", "g<C-a>", { desc = "Progressively decrement selections" })

-- Yank (copy) to system clipboard
map({ "n", "v" }, "Y", [["+y]], { desc = "Yank to clipboard" })

-- Move text up/down with proper indentation
map("n", "<C-j>", "<Cmd>m .+1<CR>==", { desc = "Move down" })
map("n", "<C-k>", "<Cmd>m .-2<CR>==", { desc = "Move up" })
map("v", "<C-j>", ":m '>+1<cr>gv=gv", { desc = "Move down" })
map("v", "<C-k>", ":m '<-2<cr>gv=gv", { desc = "Move up" })

-- Move buffers left/right in the bufferline
map("n", "<C-h>", "<Cmd>BufferLineMovePrev<CR>", { desc = "Move buffer left" })
map("n", "<C-l>", "<Cmd>BufferLineMoveNext<CR>", { desc = "Move buffer right" })

-- Open horizontal/vertical splits
map("n", [[\]], "<Cmd>wincmd s<CR>", { desc = "New horizontal split" })
map("n", [[|]], "<Cmd>wincmd v<CR>", { desc = "New vertical split" })

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

-- Exit terminal mode more easily
map("t", [[<C-\>]], [[<C-\><C-n>]])

-- Toggle terminals
map({ "n", "t", "v" }, [[<M-'>]], "<Cmd>ToggleTerm direction=float<CR>", { desc = "Toggle floating terminal" })
map(
  { "n", "t", "v" },
  [[<M-\>]],
  "<Cmd>ToggleTerm size=15 direction=horizontal<CR>",
  { desc = "Toggle horizontal terminal" }
)
map(
  { "n", "t", "v" },
  [[<M-|>]],
  "<Cmd>ToggleTerm size=80 direction=vertical<CR>",
  { desc = "Toggle vertical terminal" }
)
