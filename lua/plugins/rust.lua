vim.pack.add({
	"https://github.com/mrcjkb/rustaceanvim",
	"https://github.com/rust-lang/rust.vim",
	"https://github.com/saecki/crates.nvim",
})
vim.g.rustfmt_autosave = 1
require("crates").setup()
