return {
	"Civitasv/cmake-tools.nvim",
	keys = {
		{ desc = "CMake generate", "<leader>cg", "<cmd>CMakeGenerate<CR>" },
		{ desc = "CMake build", "<leader>cb", "<cmd>CMakeBuild<CR>" },
		{ desc = "CMake run", "<leader>cr", "<cmd>CMakeRun<CR>" },
		{ desc = "CMake select build target", "<leader>ct", "<cmd>CMakeSelectBuildTarget<CR>" },
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
