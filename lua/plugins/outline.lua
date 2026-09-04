vim.pack.add({ "https://github.com/hedyhli/outline.nvim" })

vim.keymap.set("n", "<leader>oo", "<cmd>Outline<CR>", { desc = "Toggle Outline" })

require("outline").setup({})
