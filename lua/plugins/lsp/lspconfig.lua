return {
	"neovim/nvim-lspconfig",
	event = { "BufReadPre", "BufNewFile" },
	dependencies = {
		"hrsh7th/cmp-nvim-lsp",
		{ "antosha417/nvim-lsp-file-operations", config = true },
		{ "folke/neodev.nvim", opts = {} },
		"mason-org/mason.nvim",
		"mason-org/mason-lspconfig.nvim",
	},
	config = function()
		-- import cmp-nvim-lsp plugin for capabilities
		local cmp_nvim_lsp = require("cmp_nvim_lsp")

		-- Get default capabilities
		local capabilities = cmp_nvim_lsp.default_capabilities()
		capabilities.offsetEncoding = { "utf-16" }

		-- Configure diagnostic display
		vim.diagnostic.config({
			signs = {
				text = {
					[vim.diagnostic.severity.ERROR] = " ",
					[vim.diagnostic.severity.WARN] = " ",
					[vim.diagnostic.severity.HINT] = "󰠠 ",
					[vim.diagnostic.severity.INFO] = " ",
				},
			},
		})

		-- Configure global settings for ALL LSP servers
		vim.lsp.config("*", {
			capabilities = capabilities,
			root_markers = { ".git" },
		})

		-- Manually enable LSP servers
		-- These will auto-start when opening matching filetypes
		local servers = {
			"html",
			"clangd",
			"cssls",
			"lua_ls",
			"emmet_ls",
			"pyright",
			"ts_ls",
		}

		for _, server in ipairs(servers) do
			vim.lsp.enable(server)
		end

		-- Configure pyright to use Python from PATH
		vim.lsp.config("pyright", {
			settings = {
				python = {
					pythonPath = vim.fn.exepath("python3"),
				},
			},
		})
	end,
}
