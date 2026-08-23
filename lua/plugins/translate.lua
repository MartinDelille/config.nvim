vim.pack.add({ "https://github.com/uga-rosa/translate.nvim" })
require("translate").setup({
  default = {
    command = "google",
    source_lang = "auto",
    output = "replace",
  },
})

vim.keymap.set("n", "<leader>tre", "viw<cmd>Translate en -output=replace<CR>", { desc = "Translate word under cursor in english and replace" })
vim.keymap.set("n", "<leader>trf", "viw<cmd>Translate fr -output=replace<CR>", { desc = "Translate word under cursor in frech and replace" })
vim.keymap.set("v", "<leader>tre", "<cmd>Translate en -output=replace<CR>", { desc = "Translate selection in english and replace" })
vim.keymap.set("v", "<leader>trf", "<cmd>Translate fr -output=replace<CR>", { desc = "Translate selection in french and replace" })
