return {
	"stevearc/oil.nvim",
	---@module 'oil'
	---@type oil.SetupOpts
	opts = {
		git = {
			mv = function(src_path, dest_path) return true end,
		},
	},
	keys = {
		{ "-", function() vim.cmd("Oil") end, desc = "Open parent directory" },
	},
	dependencies = { { "nvim-mini/mini.icons", opts = {} } },
	lazy = false,
}
