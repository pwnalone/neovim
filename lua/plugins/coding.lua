return {
  {
    "L3MON4D3/LuaSnip",
    build = "make install_jsregexp",
    dependencies = { "rafamadriz/friendly-snippets" },
    config = function()
      require("luasnip.loaders.from_vscode").lazy_load()
    end,
  },

  {
    "hrsh7th/nvim-cmp",
    version = false,
    dependencies = {
      "hrsh7th/cmp-buffer",
      "hrsh7th/cmp-nvim-lsp",
      "hrsh7th/cmp-path",

      { "saadparwaiz1/cmp_luasnip", dependencies = { "LuaSnip" } },
    },
    event = "InsertEnter",
    opts = function()
      local cmp = require("cmp")

      local expand_snippet = function(args)
        require("luasnip").lsp_expand(args.body)
      end

      return {
        snippet = { expand = expand_snippet },
        mapping = cmp.mapping.preset.insert(),
        sources = cmp.config.sources({
          { name = "nvim_lsp" },
          { name = "luasnip" },
          { name = "buffer" },
          { name = "path" },
        }),
      }
    end,
  },
}
