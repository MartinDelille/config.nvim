return {
	{
		"github/copilot.vim",
		config = function()
			vim.g.copilot_filetypes = {
				["gitcommit"] = true,
			}
		end,
	},
	{
		"olimorris/codecompanion.nvim",
		dependencies = {
			"nvim-lua/plenary.nvim",
			"ravitemer/codecompanion-history.nvim",
		},
		keys = {
			{ "<leader>cc", "<cmd>CodeCompanionChat Toggle<cr>", desc = "Code Companion" },
		},
		opts = {
			strategies = {
				inline = {
					keymaps = {
						accept_change = { modes = { n = "<leader>ca" } },
						reject_change = { modes = { n = "<leader>cr" } },
						always_accept = { modes = { n = "<leader>cy" } },
					},
				},
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
		},
	},
}
