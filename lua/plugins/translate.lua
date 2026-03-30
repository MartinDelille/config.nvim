vim.pack.add({ "https://github.com/uga-rosa/translate.nvim" })
require("translate").setup({
	default = {
		command = "google",
		source_lang = "auto",
		target_lang = "en",
		output = "replace",
	},
})

vim.keymap.set("n", "<leader>tr", "viw<cmd>Translate en -output=replace<CR>", { desc = "Translate word under cursor and replace" })
vim.keymap.set("v", "<leader>tr", "<cmd>Translate en -output=replace<CR>", { desc = "Translate selection and replace" })
