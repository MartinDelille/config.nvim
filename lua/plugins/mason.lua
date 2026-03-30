vim.pack.add({
	{ src = "https://github.com/mason-org/mason.nvim" },
	{ src = "https://github.com/mason-org/mason-lspconfig.nvim" },
	{ src = "https://github.com/WhoIsSethDaniel/mason-tool-installer.nvim" },
})

local mason = require("mason")
local mason_lspconfig = require("mason-lspconfig")
local mason_tool_installer = require("mason-tool-installer")

-- Enable mason and configure icons
mason.setup({
	ui = {
		icons = {
			package_installed = "✓",
			package_pending = "➜",
			package_uninstalled = "✗",
		},
	},
	pip = {
		upgrade_pip = true,
	},
})

mason_lspconfig.setup({
	ensure_installed = {
		"basedpyright",
		"html",
		"clangd",
		"copilot",
		"cssls",
		"lua_ls",
		"emmet_ls",
		"pyright",
		"ts_ls",
		"angularls",
		"qmlls",
	},
})

mason_tool_installer.setup({
	ensure_installed = {
		"clang-format",
		"codelldb",
		"cpplint",
		"debugpy",
		"js-debug-adapter",
		"prettier",
		"stylelint",
		"stylua",
		"mbake",
		"pylint",
		"eslint_d",
		"rust-analyzer",
		"gdtoolkit",
		"shfmt",
	},
})
