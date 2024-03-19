local plugins = {
  {
    "nvim-telescope/telescope.nvim",
    branch = "0.1.x",
    dependencies = {
      "nvim-lua/plenary.nvim",
      "nvim-tree/nvim-web-devicons",
    },
    cmd = { "Telescope" },
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
          n = vim.tbl_extend("force", keymaps, { ["q"] = actions.close }),
        },
        vimgrep_arguments = {
          "rg",
          "--color=never",
          "--no-heading",
          "--with-filename",
          "--line-number",
          "--column",
          "--smart-case",
          "--trim",
          "--hidden",
          "--glob=!.git/",
        },
      }

      opts.pickers = {
        find_files = {
          find_command = { "rg", "--files", "--hidden", "--glob=!.git/" },
        },
        colorscheme = { enable_preview = true },
        grep_string = { only_sort_text = true },
        live_grep = { only_sort_text = true },
        man_pages = { sections = { "ALL" } },
        planets = { show_pluto = true },
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
}

if vim.fn.executable("make") then
  plugins[#plugins + 1] = {
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

return plugins
