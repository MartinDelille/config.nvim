return {
	"kevinhwang91/nvim-ufo",
	-- lazy = false,
	dependencies = "kevinhwang91/promise-async",
	config = function()
		vim.o.foldlevelstart = 99
		require("ufo").setup({
			provider_selector = function(bufnr, filetype, buftype) return { "lsp", "indent" } end,
		})
	end,
	-- keys = {
	-- Top Pickers & Explorer
	-- { "zR", require("ufo").openAllFolds, desc = "Open all folds" },
	-- { "zM", require("ufo").closeAllFolds, desc = "Close all folds" },
	-- },
}
