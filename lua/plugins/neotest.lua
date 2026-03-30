vim.pack.add({ "https://github.com/nvim-neotest/neotest" })
local neotest = require("neotest")
neotest().setup({
	adapters = {
		require("neotest-python")({
			dap = { justMyCode = false },
			runner = "pytest",
		}),
	},
})
vim.keymap.set("n", "<leader>ts", function() neotest.run.run() end, { desc = "Run nearest tests" })
vim.keymap.set("n", "<leader>tw", function() neotest.run.run(vim.fn.expand("%")) end, { desc = "Run all tests in current file" })
vim.keymap.set("n", "<leader>tw", function() neotest.watch.watch(vim.fn.expand("%")) end, { desc = "Watch current test file" })
vim.keymap.set("n", "<leader>to", function() neotest.output_panel.toggle() end, { desc = "Open neotest output panel (right)" })
vim.keymap.set("n", "<leader>tsu", function() neotest.summary.toggle() end, { desc = "Open neotest summary panel (right)" })
