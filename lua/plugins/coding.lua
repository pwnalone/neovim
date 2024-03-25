return {
  -- Customize autocompletion options and replace keymaps with custom ones.
  {
    "nvim-cmp",
    opts = function(_, opts)
      local cmp = require("cmp")
      local luasnip = require("luasnip")

      local next_placeholder_or_fallback = function(fallback)
        if luasnip.expand_or_jumpable() then
          luasnip.expand_or_jump()
        else
          fallback()
        end
      end

      local prev_placeholder_or_fallback = function(fallback)
        if luasnip.jumpable(-1) then
          luasnip.jump(-1)
        else
          fallback()
        end
      end

      local complete_or_ = function(fallback)
        return function()
          if not cmp.visible() then
            cmp.complete()
          else
            fallback()
          end
        end
      end

      local complete_or_select_next_item = complete_or_(cmp.select_next_item)
      local complete_or_select_prev_item = complete_or_(cmp.select_prev_item)

      local scroll_docs_up = function()
        cmp.scroll_docs(-2)
      end
      local scroll_docs_dn = function()
        cmp.scroll_docs(2)
      end

      local bordered = cmp.config.window.bordered({ border = "rounded", scrolloff = 2 })

      opts.window = { completion = bordered, documentation = bordered }

      if not opts.completion.completeopt:match("noselect") then
        opts.completion.completeopt = opts.completion.completeopt .. ",noselect"
      end

      opts.mapping = {
        ["<C-Space>"] = cmp.mapping(cmp.mapping.complete(), { "i", "c" }),
        ["<C-c>"] = cmp.mapping(cmp.abort, { "i", "c" }),
        ["<C-d>"] = cmp.mapping(scroll_docs_dn, { "i", "c" }),
        ["<C-j>"] = cmp.mapping(complete_or_select_next_item, { "i", "c" }),
        ["<C-k>"] = cmp.mapping(complete_or_select_prev_item, { "i", "c" }),
        ["<C-n>"] = cmp.config.disable,
        ["<C-p>"] = cmp.config.disable,
        ["<C-u>"] = cmp.mapping(scroll_docs_up, { "i", "c" }),
        ["<CR>"] = cmp.mapping(cmp.mapping.confirm(), { "i", "c" }),
        ["<S-Tab>"] = cmp.mapping({
          c = complete_or_select_prev_item,
          i = prev_placeholder_or_fallback,
          s = prev_placeholder_or_fallback,
        }),
        ["<Tab>"] = cmp.mapping({
          c = complete_or_select_next_item,
          i = next_placeholder_or_fallback,
          s = next_placeholder_or_fallback,
        }),
      }

      return opts
    end,
  },

  -- Enable cmdline autocompletion.
  {
    "nvim-cmp",
    event = "CmdlineEnter",
    dependencies = { "hrsh7th/cmp-cmdline" },
    config = function(_, opts)
      local cmp = require("cmp")
      for _, source in ipairs(opts.sources) do
        source.group_index = source.group_index or 1
      end
      cmp.setup(opts)
      cmp.setup.cmdline({ "/", "?" }, {
        ---@diagnostic disable-next-line: missing-fields
        formatting = { fields = { "abbr", "menu" } },
        sources = cmp.config.sources({
          { name = "buffer" },
        }),
      })
      cmp.setup.cmdline({ ":" }, {
        ---@diagnostic disable-next-line: missing-fields
        formatting = { fields = { "abbr", "menu" } },
        sources = cmp.config.sources({
          { name = "path" },
        }, {
          { name = "cmdline" },
        }),
      })
    end,
  },

  -- Interactive text alignment (see `:help mini.align`).
  {
    "echasnovski/mini.align",
    event = "VeryLazy",
    opts = {},
  },

  -- Split/join blocks of code.
  {
    "Wansmer/treesj",
    dependencies = { "nvim-treesitter/nvim-treesitter" },
    cmd = { "TSJJoin", "TSJSplit", "TSJToggle" },
    keys = {
      {
        "<Leader>j",
        function()
          require("treesj").toggle({ both = { recursive = false } })
        end,
        desc = "Toggle split/join",
      },
      {
        "<Leader>J",
        function()
          require("treesj").toggle({ split = { recursive = true } })
        end,
        desc = "Toggle split/join (recursively)",
      },
    },
    opts = {
      use_default_keymaps = false,
      max_join_length = 999,
    },
  },

  -- Customize Yanky options and modify default keymaps.
  {
    "gbprod/yanky.nvim",
    opts = function(_, opts)
      local mapping = require("yanky.telescope.mapping")

      opts.picker = {
        telescope = {
          use_default_mappings = false,
          mappings = {
            default = mapping.put("p"),
          },
        },
      }

      return opts
    end,
    keys = function(_, keys)
      local keymaps = {}
      for _, map in ipairs(keys) do
        keymaps[map[1]] = map
      end

      keymaps["<C-n>"] = keymaps["[y"]
      keymaps["<C-p>"] = keymaps["]y"]
      keymaps["[y"] = nil
      keymaps["]y"] = nil

      keys = {}
      for k, v in pairs(keymaps) do
        table.insert(keys, v)
        v[1] = k
      end

      return keys
    end,
  },
}
