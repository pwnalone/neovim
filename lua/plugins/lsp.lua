return {
	{ "folke/neodev.nvim", opts = {} },

	{
		"neovim/nvim-lspconfig",
		dependencies = { "neodev.nvim", "mason.nvim", "mason-lspconfig.nvim" },
		event = "User FileOpened",
		keys = {
			{ "<Leader>li", "<Cmd>LspInfo<CR>", "LSP info" },
		},
		cmd = {
			"LspInfo",
			"LspInstall",
			"LspLog",
			"LspRestart",
			"LspStart",
			"LspStop",
			"LspUninstall",
		},
	},

	{
		"williamboman/mason.nvim",
		build = ":MasonUpdate",
		cmd = {
			"Mason",
			"MasonInstall",
			"MasonLog",
			"MasonUninstall",
			"MasonUninstallAll",
			"MasonUpdate",
		},
		keys = {
			{ "<leader>m", "<Cmd>Mason<CR>", desc = "Mason" },
		},
		config = function(_, opts)
			require("mason").setup(opts)
			local mr = require("mason-registry")
			mr:on("package:install:success", function()
				vim.defer_fn(function()
					vim.api.nvim_exec_autocmds("FileType", { buffer = 0 })
				end, 100)
			end)
			local ensure = function()
				for _, tool in ipairs(opts.ensure_installed) do
					local p = mr.get_package(tool)
					if not p:is_installed() then
						p:install()
					end
				end
			end
			if mr.refresh then
				mr.refresh(ensure)
			else
				ensure()
			end
		end,
		opts = {
			ensure_installed = {
				"stylua",
			},
		},
	},

	{
		"williamboman/mason-lspconfig.nvim",
		config = function(_, opts)
			if opts.handlers and not opts.handlers[1] then
				opts.handlers[1] = function(server)
					local capabilities = nil
					local ok, cmp_nvim_lsp = pcall(require, "cmp_nvim_lsp")
					if not ok then
						capabilities = vim.lsp.protocol.make_client_capabilities()
					else
						capabilities = cmp_nvim_lsp.default_capabilities()
					end
					local lsp_defaults = opts.lsp_defaults or {}
					local lsp_opts = vim.tbl_deep_extend("keep", lsp_defaults, {
						capabilities = capabilities,
					})
					require("lspconfig")[server].setup(lsp_opts)
				end
			end
			require("mason-lspconfig").setup(opts)
		end,
		opts = {
			handlers = {},
			ensure_installed = {
				"lua_ls",
			},
		},
	},
}
