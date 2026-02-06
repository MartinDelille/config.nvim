return {
	"nvim-lualine/lualine.nvim",
	dependencies = { "nvim-tree/nvim-web-devicons" },
	config = function()
		local lualine = require("lualine")
		lualine.setup({
			extensions = { "quickfix" },
			sections = {
				lualine_c = {
					{
						"filename",
						path = 1,
						shorting_target = 40,
					},
				},
				lualine_x = {
					require("plugins.extensions.lualine_codecompanion"),
					"encoding",
					"fileformat",
					"filetype",
				},
			},
		})
	end,
}
