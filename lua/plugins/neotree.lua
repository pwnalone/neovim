local copy_path_to_clipboard = function(state)
  local node = state.tree:get_node()
  local path = node:get_id()
  vim.fn.setreg("+", path, "c")
end

local navigate_up_or_close = function(state)
  local node = state.tree:get_node()
  if node.type == "directory" and node:is_expanded() then
    require("neo-tree.sources.filesystem").toggle_directory(state, node)
  else
    node = node:get_parent_id()
    if node ~= nil then
      require("neo-tree.ui.renderer").focus_node(state, node)
    else
      state.commands["navigate_up"](state)
    end
  end
end

local navigate_down_or_nop = function(state)
  local node = state.tree:get_node()
  if node.type ~= "directory" then
    return
  end
  if not node:is_expanded() then
    require("neo-tree.sources.filesystem").toggle_directory(state, node)
  elseif node:has_children() then
    node = node:get_child_ids()[1]
    if node ~= nil then
      require("neo-tree.ui.renderer").focus_node(state, node)
    end
  end
end

local open_without_focus = function(state)
  local node = state.tree:get_node()
  if require("neo-tree.utils").is_expandable(node) then
    state.commands["toggle_node"](state)
  else
    state.commands["open"](state)
    vim.cmd("Neotree reveal")
  end
end

return {
  {
    "nvim-neo-tree/neo-tree.nvim",
    branch = "v3.x",
    dependencies = {
      "nvim-lua/plenary.nvim",
      "nvim-tree/nvim-web-devicons",
      "MunifTanjim/nui.nvim",
    },
    cmd = "Neotree",
    --
    -- FIXME: These keymaps sometimes cause an error.
    --
    -- E.g. An error occurs when Neotree is open on the left and you toggle the popup or vice-versa.
    --
    keys = {
      {
        "<Leader>e",
        "<Cmd>Neotree filesystem close float<CR><Cmd>Neotree filesystem toggle left<CR>",
        desc = "Toggle file explorer",
      },
      {
        "<Leader>E",
        "<Cmd>Neotree filesystem close left<CR><Cmd>Neotree filesystem toggle float<CR>",
        desc = "Toggle file explorer (popup)",
      },
    },
    init = function()
      if vim.fn.argc(-1) == 1 then
        ---@diagnostic disable-next-line: param-type-mismatch
        local stat = vim.loop.fs_stat(vim.fn.argv(0))
        if stat and stat.type == "directory" then
          require("neo-tree")
        end
      end
    end,
    opts = {
      sources = { "filesystem", "buffers", "git_status", "document_symbols" },
      source_selector = { winbar = true },
      close_if_last_window = true,
      popup_border_style = "rounded",
      commands = {
        copy_path_to_clipboard = copy_path_to_clipboard,
        navigate_up_or_close = navigate_up_or_close,
        navigate_down_or_nop = navigate_down_or_nop,
        open_without_focus = open_without_focus,
      },
      window = {
        mappings = {
          ["<space>"] = "none",
          ["<tab>"] = "open_without_focus",
        },
        fuzzy_finder_mappings = {
          ["<C-j>"] = "move_cursor_down",
          ["<C-k>"] = "move_cursor_up",
          ["<C-n>"] = "none",
          ["<C-p>"] = "none",
        },
      },
      filesystem = {
        gollow_current_file = { enabled = true },
        use_libuv_file_watcher = true,
        hijack_netrw_behavior = "open_current",
        window = {
          mappings = {
            ["L"] = "focus_preview",
            ["Y"] = "copy_path_to_clipboard",
            ["Z"] = "expand_all_nodes",
            ["h"] = "navigate_up_or_close",
            ["l"] = "navigate_down_or_nop",
          },
        },
      },
      buffers = {
        follow_current_file = { enabled = true },
      },
    },
  },
}
