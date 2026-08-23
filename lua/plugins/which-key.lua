vim.pack.add({
  "https://github.com/folke/which-key.nvim",
  "https://github.com/nvim-tree/nvim-web-devicons",
})

vim.o.timeout = true
vim.o.timeoutlen = 500

require("which-key").setup()
