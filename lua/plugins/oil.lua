return {
	"stevearc/oil.nvim",
	---@module 'oil'
	---@type oil.SetupOpts
	keys = {
		{ "-", function() vim.cmd("Oil") end, desc = "Open parent directory" },
	},
	dependencies = { { "nvim-mini/mini.icons", opts = {} } },
	lazy = false,
}
