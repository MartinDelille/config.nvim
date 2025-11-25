return {
	"nvim-lua/plenary.nvim",
	"christoomey/vim-tmux-navigator",
	{
		"catgoose/nvim-colorizer.lua",
		config = function() require("colorizer").setup() end,
	},
	"rhysd/conflict-marker.vim",
	{ "habamax/vim-godot", event = "VimEnter" },
}
