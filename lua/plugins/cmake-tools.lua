vim.pack.add({ "https://github.com/Civitasv/cmake-tools.nvim" })
require("cmake-tools").setup({
	cmake_runner = {
		name = "quickfix",
		opts = {
			show = "always",
			position = "belowright",
			size = 40,
			encoding = "utf-8",
			auto_close_when_success = false,
		},
	},
})

vim.keymap.set("n", "<leader>cg", function() vim.cmd.CMakeGenerate() end, { desc = "CMake generate" })
vim.keymap.set("n", "<leader>cb", function() vim.cmd.CMakeBuild() end, { desc = "CMake build" })
vim.keymap.set("n", "<leader>cr", function() vim.cmd.CMakeRun() end, { desc = "CMake run" })
vim.keymap.set("n", "<leader>ct", function() vim.cmd.CMakeRunTest() end, { desc = "CMake run tests" })
vim.keymap.set("n", "<leader>cs", function() vim.cmd.CMakeSelectBuildTarget() end, { desc = "CMake select build target" })
