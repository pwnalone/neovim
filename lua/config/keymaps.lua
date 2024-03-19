local map = function(mode, lhs, rhs, opts)
  local base = { noremap = true, silent = true }
  vim.keymap.set(mode, lhs, rhs, vim.tbl_extend("force", base, opts or {}))
end

-- Clear search with <Esc>
map({ "i", "n" }, "<Esc>", "<Cmd>noh<CR><Esc>")

-- Better up/down movement
map({ "n", "x" }, "j", "v:count == 0 ? 'gj' : 'j'", { expr = true })
map({ "n", "x" }, "<Down>", "v:count == 0 ? 'gj' : 'j'", { expr = true })
map({ "n", "x" }, "k", "v:count == 0 ? 'gk' : 'k'", { expr = true })
map({ "n", "x" }, "<Up>", "v:count == 0 ? 'gk' : 'k'", { expr = true })

-- Hold onto selection when indenting/dedenting
map("v", "<", "<gv")
map("v", ">", ">gv")
