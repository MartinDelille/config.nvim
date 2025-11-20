return {
	{ "catppuccin/vim" },
	{ "folke/tokyonight.nvim" },
	{ "navarasu/onedark.nvim" },
	{ "projekt0n/github-nvim-theme" },
	{ "EdenEast/nightfox.nvim" },
	{ "rebelot/kanagawa.nvim" },
	{ "sainnhe/everforest" },
	{ "sainnhe/gruvbox-material" },
	{ "sainnhe/sonokai" },
	{ "marko-cerovac/material.nvim" },
	{
		"sonph/onehalf",
		config = function(plugin) vim.opt.rtp:append(plugin.dir .. "/vim") end,
	},
}
