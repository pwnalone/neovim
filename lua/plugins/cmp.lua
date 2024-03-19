return {
  {
    "L3MON4D3/LuaSnip",
    version = "*",
    build = "make install_jsregexp",
    dependencies = { "rafamadriz/friendly-snippets" },
    config = function()
      require("luasnip.loaders.from_vscode").lazy_load()
    end,
  },

  {
    "hrsh7th/nvim-cmp",
    dependencies = {
      "onsails/lspkind.nvim",

      "hrsh7th/cmp-buffer",
      "hrsh7th/cmp-nvim-lsp",
      "hrsh7th/cmp-path",

      { "saadparwaiz1/cmp_luasnip", dependencies = { "LuaSnip" } },
    },
    event = "InsertEnter",
    opts = function(_, opts)
      local cmp = require("cmp")
      local lspkind = require("lspkind")
      local luasnip = require("luasnip")

      local expand_snippet = function(args)
        luasnip.lsp_expand(args.body)
      end

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

      local complete_or = function(fallback)
        return function()
          if not cmp.visible() then
            cmp.complete()
          else
            fallback()
          end
        end
      end

      local complete_or_select_next_item = complete_or(cmp.select_next_item)
      local complete_or_select_prev_item = complete_or(cmp.select_prev_item)

      local scroll_docs_up = function()
        cmp.scroll_docs(-2)
      end
      local scroll_docs_dn = function()
        cmp.scroll_docs(2)
      end

      local bordered = cmp.config.window.bordered({ border = "rounded", scrolloff = 2 })

      opts.window = { completion = bordered, documentation = bordered }

      opts.formatting = { format = lspkind.cmp_format() }

      opts.snippet = { expand = expand_snippet }

      opts.mapping = {
        ["<C-Space>"] = cmp.mapping(cmp.mapping.complete(), { "i", "c" }),
        ["<C-c>"] = cmp.mapping(cmp.abort, { "i", "c" }),
        ["<C-d>"] = cmp.mapping(scroll_docs_dn, { "i", "c" }),
        ["<C-j>"] = cmp.mapping(complete_or_select_next_item, { "i", "c" }),
        ["<C-k>"] = cmp.mapping(complete_or_select_prev_item, { "i", "c" }),
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

      opts.sources = cmp.config.sources({
        { name = "nvim_lsp" },
        { name = "luasnip" },
        { name = "buffer" },
        { name = "path" },
      })

      return opts
    end,
  },

  {
    "hrsh7th/nvim-cmp",
    event = "CmdlineEnter",
    dependencies = { "hrsh7th/cmp-cmdline" },
    config = function(_, opts)
      local cmp = require("cmp")

      cmp.setup(opts)

      cmp.setup.cmdline({ "/", "?" }, {
        ---@diagnostic disable-next-line: missing-fields
        formatting = { fields = { "abbr", "menu" } },
        sources = cmp.config.sources({
          { name = "buffer" },
        }),
      })

      cmp.setup.cmdline(":", {
        ---@diagnostic disable-next-line: missing-fields
        formatting = { fields = { "abbr", "menu" } },
        sources = cmp.config.sources({
          { name = "path" },
          { name = "cmdline" },
        }),
      })
    end,
  },
}
