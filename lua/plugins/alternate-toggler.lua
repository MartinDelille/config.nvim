vim.pack.add({ "https://github.com/rmagatti/alternate-toggler" })

vim.keymap.set("n", "<leader>tt", function() require("alternate-toggler").toggleAlternate() end, { desc = "Toggle boolean" })
