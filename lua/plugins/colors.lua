-- NOTE: Both Tokyonight and Catppuccin are already installed.

--
-- NOTE: This may eventually become unnecessary...
--
-- Track issue: https://github.com/rebelot/kanagawa.nvim/issues/220
-- Track issue: https://github.com/marko-cerovac/material.nvim/issues/196
--
local util = require("util.colors")

return {
  -- Gruvbox Material
  {
    "sainnhe/gruvbox-material",
    lazy = true,
    config = function()
      vim.g.gruvbox_material_background = "hard"
      vim.g.gruvbox_material_float_style = "dim"
      vim.g.gruvbox_material_diagnostic_virtual_text = "highlighted"
      vim.g.gruvbox_material_better_performance = true
    end,
  },

  -- Kanagawa
  {
    "rebelot/kanagawa.nvim",
    version = false,
    lazy = true,
    opts = {
      colors = {
        theme = {
          all = {
            ui = {
              bg_gutter = "none",
            },
          },
        },
      },
      overrides = function(config)
        local theme = config.theme

        local color = require("kanagawa.lib.color")

        local make_highlight = function(c)
          return { fg = c, bg = color(c):blend(theme.ui.bg, 0.95):to_hex() }
        end

        -- stylua: ignore
        return {
          DiagnosticVirtualTextHint  = make_highlight(theme.diag.hint),
          DiagnosticVirtualTextInfo  = make_highlight(theme.diag.info),
          DiagnosticVirtualTextWarn  = make_highlight(theme.diag.warning),
          DiagnosticVirtualTextError = make_highlight(theme.diag.error),
        }
      end,
    },
  },

  -- Material
  {
    "marko-cerovac/material.nvim",
    version = false,
    lazy = true,
    opts = function()
      vim.g.material_style = "darker"

      local colors = require("material.colors")

      local make_highlight = function(color)
        return { bg = util.darken(color, 0.1, colors.editor.bg), fg = color }
      end

      return {
        disable = { colored_cursor = true },
        contrast = {
          floating_windows = true,
          sidebars = true,
        },
        styles = {
          comments = {
            italic = true,
          },
        },
        plugins = {
          "dap",
          "dashboard",
          "eyeliner",
          "fidget",
          "flash",
          "gitsigns",
          "harpoon",
          "hop",
          "illuminate",
          "indent-blankline",
          "lspsaga",
          "neo-tree",
          "neogit",
          "neorg",
          "neotest",
          "noice",
          "nvim-cmp",
          "nvim-navic",
          "nvim-notify",
          "nvim-tree",
          "nvim-web-devicons",
          "rainbow-delimiters",
          "sneak",
          "telescope",
          "trouble",
          "which-key",

          -- "mini",  -- Breaks mini.indentscope highlighting...
        },
        -- stylua: ignore
        custom_highlights = {
          DiagnosticVirtualTextHint  = make_highlight(colors.lsp.hint),
          DiagnosticVirtualTextInfo  = make_highlight(colors.lsp.info),
          DiagnosticVirtualTextWarn  = make_highlight(colors.lsp.warning),
          DiagnosticVirtualTextError = make_highlight(colors.lsp.error),
        },
      }
    end,
  },

  -- Nightfox
  {
    "EdenEast/nightfox.nvim",
    lazy = true,
    opts = { options = { styles = { comments = "italic" } } },
  },

  -- Nordic
  {
    "AlexvZyl/nordic.nvim",
    version = false,
    lazy = true,
  },

  -- One Dark
  {
    "navarasu/onedark.nvim",
    version = false,
    lazy = true,
    opts = {
      style = "deep",
      diagnostics = {
        darker = false,
      },
    },
  },

  -- Rosé Pine
  {
    "rose-pine/neovim",
    name = "rose-pine",
    lazy = true,
  },

  -- Pick colorscheme
  { "LazyVim/LazyVim", opts = { colorscheme = "tokyonight" } },
}
