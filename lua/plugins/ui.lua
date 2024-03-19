return {
	{
		"akinsho/bufferline.nvim",
		version = "*",
		dependencies = { "nvim-tree/nvim-web-devicons" },
		event = "VeryLazy",
		opts = {
			options = {
				diagnostics = "nvim_lsp",
				diagnostics_update_in_insert = false,
				always_show_bufferline = false,
				offsets = {
					{
						filetype = "neo-tree",
						text = "Neotree",
						text_align = "center",
						highlight = "Directory",
					},
				},
			},
		},
	},

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

	{
		"lukas-reineke/indent-blankline.nvim",
		version = "*",
		event = "User FileOpened",
		main = "ibl",
		opts = {
			indent = {
				char = "│",
				tab_char = "│",
			},
			scope = {
				enabled = false,
			},
			exclude = {
				-- TODO: Factor this out into a util variable...
				filetypes = {
					"Trouble",
					"alpha",
					"dashboard",
					"help",
					"lazy",
					"lazyterm",
					"mason",
					"neo-tree",
					"notify",
					"toggleterm",
					"trouble",
				},
			},
		},
	},

	{
		"echasnovski/mini.indentscope",
		version = "*",
		event = "User FileOpened",
		opts = {
			options = { try_as_border = true },
			symbol = "│",
		},
		init = function()
			vim.api.nvim_create_autocmd("FileType", {
				-- TODO: Factor this out into a util variable...
				pattern = {
					"Trouble",
					"alpha",
					"dashboard",
					"help",
					"lazy",
					"lazyterm",
					"mason",
					"neo-tree",
					"notify",
					"toggleterm",
					"trouble",
				},
				callback = function()
					---@diagnostic disable-next-line: inject-field
					vim.b.miniindentscope_disable = true
				end,
			})
		end,
	},

	{
		"nvim-lualine/lualine.nvim",
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
		},
	},
}
