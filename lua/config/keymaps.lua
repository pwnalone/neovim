local map = function(mode, lhs, rhs, opts)
  local base = { noremap = true, silent = true }
  vim.keymap.set(mode, lhs, rhs, vim.tbl_extend("force", base, opts or {}))
end

-- General
map("n", "<Leader>c", "<Cmd>bdelete<CR>", { desc = "Close buffer" })
map("n", "<Leader>q", "<Cmd>quit<CR>", { desc = "Close window" })
map("n", "<Leader>Q", "<Cmd>quitall<CR>", { desc = "Close editor" })
map("n", "<C-s>", "<Cmd>write<CR>", { desc = "Save" })

-- Clear search with <Esc>
map("n", "<Esc>", "<Cmd>nohlsearch<CR><Esc>")

-- Better up/down movement
map({ "n", "x" }, "j", "v:count == 0 ? 'gj' : 'j'", { expr = true })
map({ "n", "x" }, "<Down>", "v:count == 0 ? 'gj' : 'j'", { expr = true })
map({ "n", "x" }, "k", "v:count == 0 ? 'gk' : 'k'", { expr = true })
map({ "n", "x" }, "<Up>", "v:count == 0 ? 'gk' : 'k'", { expr = true })

-- Hold onto selection when indenting/dedenting
map("v", "<", "<gv")
map("v", ">", ">gv")

-- View/manage plugins
map("n", "<Leader>ps", "<Cmd>Lazy<CR>", { desc = "Plugins status" })

-- Enter command mode more easily
map({ "n", "v" }, ";", ":", { desc = "Enter command mode", silent = false })

-- Exit terminal mode more easily
map("t", [[<C-\>]], [[<C-\><C-n>]])

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
