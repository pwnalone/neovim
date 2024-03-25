return {
  -- Customize the code outline window.
  {
    "stevearc/aerial.nvim",
    opts = {
      layout = {
        min_width = 20,
        placement = "edge",
        resize_to_content = true,
      },
    },
  },

  -- Disable search mode to avoid prematurely exiting search in some circumstances.
  {
    "folke/flash.nvim",
    opts = { modes = { search = { enabled = false } } },
  },

  -- Customize Neo-tree appearance and add more keymaps.
  {
    "nvim-neo-tree/neo-tree.nvim",
    opts = {
      close_if_last_window = true,
      popup_border_style = "rounded",
      commands = {
        navigate_up_or_close_dir = require("util.neo-tree").navigate_up_or_close_dir,
        navigate_dn_or_open_file = require("util.neo-tree").navigate_dn_or_open_file,
        open_without_focus = require("util.neo-tree").open_without_focus,
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
        hijack_netrw_behavior = "open_current",
        window = {
          mappings = {
            ["L"] = "focus_preview",
            ["Z"] = "expand_all_nodes",
            ["h"] = "navigate_up_or_close_dir",
            ["l"] = "navigate_dn_or_open_file",
          },
        },
      },
      source_selector = {
        winbar = true,
        content_layout = "center",
        sources = {
          {
            source = "filesystem",
            display_name = " 󰉓 File ",
          },
          {
            source = "buffers",
            display_name = " 󰈚 Bufs ",
          },
          {
            source = "git_status",
            display_name = " 󰊢 Git ",
          },
          {
            source = "document_symbols",
            display_name = " 󰌗 Syms ",
          },
        },
      },
    },
  },

  -- Smart switching/resizing of splits with builtin Tmux integration.
  {
    "mrjones2014/smart-splits.nvim",
    event = "VeryLazy",
    opts = { default_amount = 1, cursor_follows_swapped_bufs = true },
  },

  -- Customize Telescope options and replace keymaps with custom ones.
  {
    "nvim-telescope/telescope.nvim",
    opts = function(_, opts)
      local actions = require("telescope.actions")

      local keymaps = {
        ["<C-c>"] = actions.close,
        ["<C-j>"] = actions.move_selection_next,
        ["<C-k>"] = actions.move_selection_previous,
        ["<C-n>"] = actions.cycle_history_next,
        ["<C-p>"] = actions.cycle_history_prev,
        ["<C-e>"] = actions.results_scrolling_down,
        ["<C-y>"] = actions.results_scrolling_up,
      }

      opts.defaults = opts.defaults or {}
      opts.defaults.layout_config = opts.defaults.layout_config or {}
      opts.defaults.layout_config.prompt_position = "top"
      opts.defaults.layout_config.scroll_speed = 2
      opts.defaults.sorting_strategy = "ascending"
      opts.defaults.mappings = opts.defaults.mappings or {}
      opts.defaults.mappings.i = vim.tbl_extend("force", opts.defaults.mappings.i or {}, keymaps)
      opts.defaults.mappings.n = vim.tbl_extend("force", opts.defaults.mappings.n or {}, keymaps)
      opts.defaults.vimgrep_arguments = {
        "rg",
        "--color=never",
        "--no-heading",
        "--with-filename",
        "--line-number",
        "--column",
        "--smart-case",
        "--trim",
        "--glob=!.{git,github}/",
      }

      opts.pickers = opts.pickers or {}
      opts.pickers.find_files = {
        find_command = { "rg", "--files", "--glob=!.{git,github}/" },
      }
      opts.pickers.man_pages = { sections = { "ALL" } }
      opts.mappings = {}

      return opts
    end,
  },

  -- Toggle terminals.
  {
    "akinsho/toggleterm.nvim",
    version = "*",
    cmd = "ToggleTerm",
    opts = {
      shading_factor = -10,
      highlights = {
        NormalFloat = { link = "NormalFloat" },
        FloatBorder = { link = "FloatBorder" },
      },
      float_opts = {
        border = "rounded",
        width = function()
          return math.floor(0.90 * vim.o.columns)
        end,
        height = function()
          return math.floor(0.90 * vim.o.lines)
        end,
      },
    },
  },
}
