return {
	"nvim-lua/plenary.nvim",
	{
		"catgoose/nvim-colorizer.lua",
		config = function() require("colorizer").setup() end,
	},
	"rhysd/conflict-marker.vim",
	{ "habamax/vim-godot", event = "VimEnter" },
	{
		"Kicamon/markdown-table-mode.nvim",
		config = function() require("markdown-table-mode").setup() end,
	},
}
