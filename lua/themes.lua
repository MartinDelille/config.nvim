vim.pack.add({
	"https://github.com/catppuccin/vim",
	"https://github.com/folke/tokyonight.nvim",
	"https://github.com/navarasu/onedark.nvim",
	"https://github.com/projekt0n/github-nvim-theme",
	"https://github.com/EdenEast/nightfox.nvim",
	"https://github.com/rebelot/kanagawa.nvim",
	"https://github.com/sainnhe/everforest",
	"https://github.com/sainnhe/gruvbox-material",
	"https://github.com/sainnhe/sonokai",
	"https://github.com/marko-cerovac/material.nvim",
	{ src = "https://github.com/sonph/onehalf", name = "onehalf" },
})
vim.opt.rtp:append(vim.fn.stdpath("data") .. "/site/pack/core/opt/onehalf/vim")
