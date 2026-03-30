vim.pack.add({ "https://github.com/stevearc/oil.nvim" })

require("mini.icons").setup({})

local oil = require("oil")
oil.setup({
	git = {
		mv = function(_, _) return true end,
	},
})

vim.keymap.set("n", "-", function() oil.open() end, { desc = "Open parent directory" })
