local M = {}

-- Remove duplicate elements from a Lua table.
--
-- If multiple elements with the same key are found, only the first one is kept.
M.tbl_dedup = function(list)
  local vals = {}
  local hash = {}
  for _, v in ipairs(list) do
    if not hash[v] then
      vals[#vals + 1] = v
      hash[v] = true
    end
  end
  return vals
end

return M
