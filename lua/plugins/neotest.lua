return {
	"nvim-neotest/neotest",
	keys = {
		{
			"<leader>ts",
			function() require("neotest").run.run() end,
			desc = "Run nearest tests",
		},
		{
			"<leader>tw",
			function() require("neotest").run.run(vim.fn.expand("%")) end,
			desc = "Run all tests in current file",
		},
		{
			"<leader>tw",
			function() require("neotest").watch.watch(vim.fn.expand("%")) end,
			desc = "Watch current test file",
		},
		{
			"<leader>to",
			function() require("neotest").output_panel.toggle() end,
			desc = "Open neotest output panel (right)",
		},
		{
			"<leader>tsu",
			function() require("neotest").summary.toggle() end,
			desc = "Open neotest summary panel (right)",
		},
	},
	dependencies = {
		"nvim-neotest/nvim-nio",
		"nvim-neotest/neotest-python",
		"nvim-lua/plenary.nvim",
		"antoinemadec/FixCursorHold.nvim",
		"nvim-treesitter/nvim-treesitter",
	},
	config = function()
		require("neotest").setup({
			adapters = {
				require("neotest-python")({
					dap = { justMyCode = false },
					runner = "pytest",
				}),
			},
		})
	end,
}
