vim.pack.add({
	"https://github.com/nvim-lua/plenary.nvim",
	"https://github.com/nvim-mini/mini.icons",
	"https://github.com/rhysd/conflict-marker.vim",
	"https://github.com/Kicamon/markdown-table-mode.nvim",
	"https://github.com/ipkiss42/xwiki.vim",
	"https://github.com/mustache/vim-mustache-handlebars",
	"https://github.com/neovim/nvim-lspconfig",
	{ src = "https://github.com/kylechui/nvim-surround", version = vim.version.range("4.0.0 - 5.0.0") },
})

require("plugins/treesitter")
require("plugins/oil")
require("plugins/snacks-config")
require("plugins/tmux-navigator")
require("plugins/formatting")
require("plugins/url-open")
require("plugins/mason")
require("plugins/which-key")
require("plugins/completion")
require("plugins/ghost")
require("plugins/cmake-tools")
require("plugins/copilot")
require("plugins/debug")
require("plugins/alternate-toggler")
require("plugins/translate")
require("plugins/rust")
