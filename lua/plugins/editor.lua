return {
  {
    "lewis6991/gitsigns.nvim",
    -- TODO: Swap this out for 'User GitFileOpened' when it is implemented.
    event = "User FileOpened",
    opts = {
      signs = {
        add = { text = "▎" },
        change = { text = "▎" },
        delete = { text = "" },
        topdelete = { text = "" },
        changedelete = { text = "▎" },
        untracked = { text = "▎" },
      },

      -- TODO: Customize these buffer-local keymaps.
      on_attach = function(buffer)
        local gs = package.loaded.gitsigns

        local map = function(mode, lhs, rhs, opts)
          local base = { noremap = true, silent = true, buffer = buffer }
          vim.keymap.set(mode, lhs, rhs, vim.tbl_extend("force", base, opts or {}))
        end

        -- Navigation
        map("n", "]h", function()
          if vim.wo.diff then
            return "]h"
          end
          vim.schedule(function()
            gs.next_hunk()
          end)
          return "<Ignore>"
        end, { expr = true })

        map("n", "[h", function()
          if vim.wo.diff then
            return "[h"
          end
          vim.schedule(function()
            gs.prev_hunk()
          end)
          return "<Ignore>"
        end, { expr = true })

        -- Actions
        map("n", "<leader>hs", gs.stage_hunk)
        map("n", "<leader>hr", gs.reset_hunk)
        map("v", "<leader>hs", function()
          gs.stage_hunk({ vim.fn.line("."), vim.fn.line("v") })
        end)
        map("v", "<leader>hr", function()
          gs.reset_hunk({ vim.fn.line("."), vim.fn.line("v") })
        end)
        map("n", "<leader>hS", gs.stage_buffer)
        map("n", "<leader>hu", gs.undo_stage_hunk)
        map("n", "<leader>hR", gs.reset_buffer)
        map("n", "<leader>hp", gs.preview_hunk)
        map("n", "<leader>hb", function()
          gs.blame_line({ full = true })
        end)
        map("n", "<leader>tb", gs.toggle_current_line_blame)
        map("n", "<leader>hd", gs.diffthis)
        map("n", "<leader>hD", function()
          gs.diffthis("~")
        end)
        map("n", "<leader>td", gs.toggle_deleted)

        -- Text object
        map({ "o", "x" }, "ih", ":<C-U>Gitsigns select_hunk<CR>")
      end,
    },
  },

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
      window = {
        mappings = {
          ["<space>"] = "none",
        },
      },
      filesystem = {
        use_libuv_file_watcher = true,
        follow_current_file = {
          enabled = true,
        },
      },
      buffers = {
        follow_current_file = {
          enabled = true,
        },
      },
    },
  },

  {
    "nvim-telescope/telescope.nvim",
    branch = "0.1.x",
    dependencies = {
      "nvim-lua/plenary.nvim",
      "nvim-tree/nvim-web-devicons",
    },
    cmd = { "Telescope" },
    -- TODO: Remove this (not part of base configuration).
    keys = {
      { "<Leader>.", "<Cmd>Telescope resume<CR>", desc = "Resume Telescope" },
      { "<Leader>/", "<Cmd>Telescope current_buffer_fuzzy_find<CR>", desc = "Fuzzy search current buffer" },

      { "<Leader>fb", "<Cmd>Telescope buffers<CR>", desc = "Buffers" },
      { "<Leader>ff", "<Cmd>Telescope find_files<CR>", desc = "Files" },
      { "<Leader>fr", "<Cmd>Telescope oldfiles<CR>", desc = "Recent files" },
      { "<Leader>fs", "<Cmd>Telescope grep_string<CR>", desc = "String under cursor" },
      { "<Leader>ft", "<Cmd>Telescope live_grep<CR>", desc = "Text" },

      { "<Leader>gC", "<Cmd>Telescope git_bcommits<CR>", desc = "List commits for current buffer" },
      { "<Leader>gS", "<Cmd>Telescope git_stash<CR>", desc = "List stashed items" },
      { "<Leader>gb", "<Cmd>Telescope git_branches<CR>", desc = "List branches" },
      { "<Leader>gc", "<Cmd>Telescope git_commits<CR>", desc = "List commits" },
      { "<Leader>gf", "<Cmd>Telescope git_files<CR>", desc = "List files" },
      { "<Leader>gs", "<Cmd>Telescope git_status<CR>", desc = "List status items" },

      { "<Leader>s/", "<Cmd>Telescope search_history<CR>", desc = "Search history" },
      { "<Leader>s:", "<Cmd>Telescope command_history<CR>", desc = "Command history" },
      { "<Leader>s;", "<Cmd>Telescope commands<CR>", desc = "Commands" },
      { "<Leader>sD", "<Cmd>Telescope diagnostics<CR>", desc = "Workspace diagnostics" },
      { "<Leader>sF", "<Cmd>Telescope filetypes<CR>", desc = "Filetypes" },
      { "<Leader>sH", "<Cmd>Telescope highlights<CR>", desc = "Highlights" },
      { "<Leader>sP", "<Cmd>Telescope planets<CR>", desc = "Planets" },
      { "<Leader>sQ", "<Cmd>Telescope quickfixhistory<CR>", desc = "Quickfix list history" },
      { "<Leader>sR", "<Cmd>Telescope registers<CR>", desc = "Registers" },
      { "<Leader>s'", "<Cmd>Telescope marks<CR>", desc = "Marks" },
      { "<Leader>sa", "<Cmd>Telescope autocommands<CR>", desc = "Autocommands" },
      { "<Leader>sc", "<Cmd>Telescope colorscheme<CR>", desc = "Colorschemes" },
      { "<Leader>sd", "<Cmd>Telescope diagnostics bufnr=0<CR>", desc = "Document diagnostics" },
      { "<Leader>sh", "<Cmd>Telescope help_tags<CR>", desc = "Help" },
      { "<Leader>sj", "<Cmd>Telescope jumplist<CR>", desc = "Jump list" },
      { "<Leader>sk", "<Cmd>Telescope keymaps<CR>", desc = "Keymaps" },
      { "<Leader>sl", "<Cmd>Telescope loclist<CR>", desc = "Location list" },
      { "<Leader>sm", "<Cmd>Telescope man_pages<CR>", desc = "Man pages" },
      { "<Leader>so", "<Cmd>Telescope vim_options<CR>", desc = "Vim options" },
      { "<Leader>sp", "<Cmd>Telescope reloader<CR>", desc = "Package reloader" },
      { "<Leader>sq", "<Cmd>Telescope quickfix<CR>", desc = "Quickfix list" },
      { "<Leader>ss", "<Cmd>Telescope symbols<CR>", desc = "Symbols" },
      { "<Leader>sz", "<Cmd>Telescope spell_suggest<CR>", desc = "Spelling suggestions" },

      { "<Leader>lC", "<Cmd>Telescope lsp_outgoing_calls<CR>", desc = "List outgoing calls" },
      -- { '<Leader>lS', '<Cmd>Telescope lsp_workspace_symbols<CR>', desc = 'List workspace symbols' },
      { "<Leader>lS", "<Cmd>Telescope lsp_dynamic_workspace_symbols<CR>", desc = "List workspace symbols" },
      { "<Leader>lc", "<Cmd>Telescope lsp_incoming_calls<CR>", desc = "List incoming calls" },
      { "<Leader>ld", "<Cmd>Telescope lsp_definitions<CR>", desc = "List definitions" },
      { "<Leader>li", "<Cmd>Telescope lsp_implementations<CR>", desc = "List implementations" },
      { "<Leader>lr", "<Cmd>Telescope lsp_references<CR>", desc = "List references" },
      { "<Leader>ls", "<Cmd>Telescope lsp_document_symbols<CR>", desc = "List document symbols" },
      { "<Leader>lt", "<Cmd>Telescope lsp_type_definitions<CR>", desc = "List type definitions" },
    },
    -- TODO: Remove this (not part of base configuration).
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

      opts.defaults = {
        set_env = { ["COLORTERM"] = "truecolor" },
        sorting_strategy = "ascending",
        layout_config = {
          prompt_position = "top",
          scroll_speed = 2,
        },
        mappings = {
          i = vim.tbl_extend("force", keymaps, {}),
          n = vim.tbl_extend("force", keymaps, {
            ["q"] = actions.close,
          }),
        },
      }

      return opts
    end,
    config = function(_, opts)
      local telescope = require("telescope")
      telescope.setup(opts)
      for ext, _ in pairs(opts.extensions) do
        telescope.load_extension(ext)
      end
    end,
  },

  (function()
    if vim.fn.executable("make") then
      return {
        "nvim-telescope/telescope.nvim",
        dependencies = {
          {
            "nvim-telescope/telescope-fzf-native.nvim",
            build = "make",
          },
        },
        opts = {
          extensions = {
            fzf = {
              fuzzy = true,
              override_generic_sorter = true,
              override_file_sorter = true,
              case_mode = "smart_case",
            },
          },
        },
      }
    end
  end)(),

  {
    "akinsho/toggleterm.nvim",
    version = "*",
    -- TODO: Remove this (not part of base configuration).
    keys = {
      {
        [[<M-'>]],
        "<Cmd>ToggleTerm direction=float<CR>",
        desc = "Toggle floating terminal",
        mode = { "n", "t", "v" },
      },
      {
        [[<M-\>]],
        "<Cmd>ToggleTerm size=15 direction=horizontal<CR>",
        desc = "Toggle horizontal terminal",
        mode = { "n", "t", "v" },
      },
      {
        [[<M-|>]],
        "<Cmd>ToggleTerm size=80 direction=vertical<CR>",
        desc = "Toggle vertical terminal",
        mode = { "n", "t", "v" },
      },
    },
    cmd = "ToggleTerm",
    opts = {
      shading_factor = -10,
      float_opts = { border = "rounded" },
      highlights = {
        NormalFloat = { link = "NormalFloat" },
        FloatBorder = { link = "FloatBorder" },
      },
    },
  },

  {
    "folke/which-key.nvim",
    event = "VeryLazy",
    opts = {},
  },
}
