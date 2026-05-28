vim.pack.add({
  { src = "https://github.com/stevearc/oil.nvim" },
  { src = "https://github.com/malewicz1337/oil-git.nvim" },
})

require("mini.icons").setup({})
require("oil-git").setup({})

local oil = require("oil")
oil.setup({
  keymaps = {
    ["<C-h>"] = false,
    ["<C-l>"] = false,
    ["<C-j>"] = false,
    ["<C-k>"] = false,
  },
  git = {
    mv = function(_, _) return true end,
  },
})

vim.keymap.set("n", "-", function() oil.open() end, { desc = "Open parent directory" })
