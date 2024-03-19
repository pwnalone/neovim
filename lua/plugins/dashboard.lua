return {
  {
    "nvimdev/dashboard-nvim",
    dependencies = { "nvim-tree/nvim-web-devicons" },
    event = "VimEnter",
    opts = function()
      local config_dir = vim.fn.stdpath("config")

      local opts = {
        theme = "doom",
        hide = {
          -- This is already taken care of by lualine.
          statusline = false,
        },
        config = {
          header = {
            [[                                                                       ]],
            [[                                                                       ]],
            [[                                                                       ]],
            [[                                                                       ]],
            [[                                                                       ]],
            [[                                                                       ]],
            [[                                                                       ]],
            [[                                                                     ]],
            [[       ████ ██████           █████      ██                     ]],
            [[      ███████████             █████                             ]],
            [[      █████████ ███████████████████ ███   ███████████   ]],
            [[     █████████  ███    █████████████ █████ ██████████████   ]],
            [[    █████████ ██████████ █████████ █████ █████ ████ █████   ]],
            [[  ███████████ ███    ███ █████████ █████ █████ ████ █████  ]],
            [[ ██████  █████████████████████ ████ █████ █████ ████ ██████ ]],
            [[                                                                       ]],
            [[                                                                       ]],
            [[                                                                       ]],
          },
          -- stylua: ignore
          center = {
            { icon = " ", key = "f", action = "Telescope find_files",                    desc = " Find file"    },
            { icon = " ", key = "n", action = "enew | startinsert",                      desc = " New file"     },
            { icon = " ", key = "r", action = "Telescope oldfiles",                      desc = " Recent files" },
            { icon = " ", key = "g", action = "Telescope live_grep",                     desc = " Find text"    },
            { icon = " ", key = "c", action = "Telescope find_files cwd=" .. config_dir, desc = " Config"       },
            -- TODO: Install persistence plugin.
            { icon = " ", key = "s", action = "lua require('persistence').load()",       desc = " Sessions"     },
            { icon = "󰒲 ", key = "l", action = "Lazy",                                    desc = " Lazy"         },
            { icon = " ", key = "q", action = "qa",                                      desc = " Quit"         },
          },
          footer = function()
            local stats = require("lazy").stats()
            local ms = math.floor(stats.startuptime * 100 + 0.5) / 100
            return {
              "",
              "⚡ Neovim loaded " .. stats.loaded .. "/" .. stats.count .. " plugins in " .. ms .. "ms",
            }
          end,
        },
      }

      for _, button in ipairs(opts.config.center) do
        button.key_format = "  %s"
      end

      return opts
    end,
    config = function(_, opts)
      local max_header = function(acc, val)
        return math.max(acc, vim.fn.strdisplaywidth(val))
      end
      local max_center = function(acc, val)
        return math.max(acc, vim.fn.strdisplaywidth(val.desc))
      end

      local header_max_width = vim.fn.reduce(opts.config.header, max_header, 0)
      local center_max_width = vim.fn.reduce(opts.config.center, max_center, 0)
      local separation = header_max_width - center_max_width

      for _, button in ipairs(opts.config.center) do
        button.desc = button.desc .. string.rep(" ", separation - #button.desc)
      end

      require("dashboard").setup(opts)
    end,
  },
}
