local lazy_status = require("lazy.status")

local branch = {
  "branch",
}

local filename = {
  "filename",
}

local filetype = {
  "filetype",
}

local location = {
  "location",
  padding = {
    left = 0,
    right = 1,
  },
}

local progress = {
  "progress",
  fmt = function()
    return "%P/%L"
  end,
}

local mode = {
  "mode",
  fmt = function()
    return "󰣙"
  end,
}

local diagnostics = {
  "diagnostics",
  sources = { "nvim_diagnostic" },
  symbols = {
    error = "",
    warn = "",
    info = "",
    hint = "",
  },
}

local updates = {
  -- Display available plugins updates.
  lazy_status.updates,
  cond = lazy_status.has_updates,
  color = { fg = "#ff9e64" },
}

local diff = {
  "diff",
  padding = { left = 2, right = 1 },
  source = vim.b.gitsigns_status_dict,
  symbols = {
    added = " ",
    modified = " ",
    removed = " ",
  },
}

-- TODO: Integrate LSP once you have it setup...
local lsp = nil

return {
  {
    "nvim-lualine/lualine.nvim",
    version = false,
    dependencies = { "nvim-tree/nvim-web-devicons" },
    event = "VeryLazy",
    init = function()
      -- Prevent the statusline from flashing on the starter page.
      vim.g.lualine_laststatus = vim.o.laststatus
      if vim.fn.argc(-1) < 1 then
        vim.o.laststatus = 0
      end
    end,
    config = function(_, opts)
      vim.o.laststatus = vim.g.lualine_laststatus
      require("lualine").setup(opts)
    end,
    opts = {
      options = {
        globalstatus = true,
        disabled_filetypes = {
          statusline = { "alpha", "dashboard", "starter" },
        },
        ignore_focus = { "neo-tree" },
      },
      sections = {
        lualine_a = { mode },
        lualine_b = { branch },
        lualine_c = { diff, diagnostics },
        lualine_x = { updates, filetype },
        lualine_y = { progress },
        lualine_z = { location },
      },
      extensions = { "lazy", "man", "mason", "neo-tree" },
    },
  },
}
