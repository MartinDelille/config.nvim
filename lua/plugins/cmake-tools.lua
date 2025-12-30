return {
	"Civitasv/cmake-tools.nvim",
	keys = {
		{ desc = "CMake generate", "<leader>cg", function() vim.cmd.CMakeGenerate() end },
		{ desc = "CMake build", "<leader>cb", function() vim.cmd.CMakeBuild() end },
		{ desc = "CMake run", "<leader>cr", function() vim.cmd.CMakeRun() end },
		{ desc = "CMake select build target", "<leader>ct", function() vim.cmd.CMakeSelectBuildTarget() end },
		{ desc = "CMake select build type", "<leader>cT", function() vim.cmd.CMakeSelectBuildType() end },
	},
	config = function()
		require("cmake-tools").setup({
			cmake_runner = {
				default_opts = {
					terminal = {
						split_direction = "vertical",
						split_size = 100,
					},
				},
			},
		})
	end,
}
