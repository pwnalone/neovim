local M = {}

M.navigate_up_or_close_dir = function(state)
  local node = state.tree:get_node()
  local next = node:get_parent_id()
  if node.type == "directory" and node:is_expanded() then
    require("neo-tree.sources.filesystem").toggle_directory(state, node)
  elseif next ~= nil then
    require("neo-tree.ui.renderer").focus_node(state, next)
  else
    state.commands["navigate_up"](state)
  end
end

M.navigate_dn_or_open_file = function(state)
  local node = state.tree:get_node()
  local next = node:get_child_ids()[1]
  if node.type == "directory" and not node:is_expanded() then
    require("neo-tree.sources.filesystem").toggle_directory(state, node)
  elseif node:has_children() and next ~= nil then
    require("neo-tree.ui.renderer").focus_node(state, next)
  else
    state.commands["open"](state)
  end
end

M.open_without_focus = function(state)
  local node = state.tree:get_node()
  if require("neo-tree.utils").is_expandable(node) then
    state.commands["toggle_node"](state)
  else
    state.commands["open"](state)
    vim.cmd("Neotree reveal")
  end
end

return M
