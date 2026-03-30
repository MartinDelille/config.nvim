vim.pack.add({
	"https://github.com/olimorris/codecompanion.nvim",
	"https://github.com/ravitemer/codecompanion-history.nvim",
})

local codecompanion = require("codecompanion")

codecompanion.setup({
	action_palette = {
		provider = "snacks",
	},
	strategies = {
		chat = {
			keymaps = {
				next_chat = false,
				previous_chat = false,
			},
		},
	},
	extensions = {
		history = {
			enabled = true,
			opts = {},
		},
	},
	interactions = {
		chat = {
			model = "claude-sonnet",
			opts = {
				completion_provider = "blink", -- blink|cmp|coc|default
			},
		},
	},
})
vim.keymap.set("n", "<leader>cc", function() codecompanion.toggle() end, { desc = "Code Companion" })
