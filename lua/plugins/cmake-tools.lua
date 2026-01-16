return {
	"Civitasv/cmake-tools.nvim",
	keys = {
		{ desc = "CMake generate", "<leader>cg", function() vim.cmd.CMakeGenerate() end },
		{ desc = "CMake build", "<leader>cb", function() vim.cmd.CMakeBuild() end },
		{ desc = "CMake run", "<leader>cr", function() vim.cmd.CMakeRun() end },
		{ desc = "CMake run tests", "<leader>ct", function() vim.cmd.CMakeRunTest() end },
		{ desc = "CMake select build target", "<leader>cs", function() vim.cmd.CMakeSelectBuildTarget() end },
		-- { desc = "CMake-tools reload", "<leader>cl", function() vim.cmd.Lazy("reload cmake-tools.nvim") end },
	},
	config = function()
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
	end,
}
