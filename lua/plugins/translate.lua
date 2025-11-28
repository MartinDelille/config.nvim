local plugin = {
	"uga-rosa/translate.nvim",
	config = function()
		require("translate").setup({
			default = {
				command = "google",
				source_lang = "auto",
				target_lang = "en",
				output = "replace",
			},
		})
	end,
	keys = {
		{ "<leader>tr", "viw<cmd>Translate en -output=replace<CR>", mode = "n", desc = "Translate word under cursor and replace" },
		{ "<leader>tr", "<cmd>Translate en -output=replace<CR>", mode = "v", desc = "Translate selection and replace" },
	},
}
return {}
