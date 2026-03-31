vim.lsp.inline_completion.enable(true)

vim.keymap.set("i", "<Tab>", function()
	if not vim.lsp.inline_completion.get() then return "<Tab>" end
end, { expr = true, desc = "Accept the current inline completion" })

-- vim.pack.add({
-- 	-- "https://github.com/hrsh7th/cmp-nvim-lsp",
-- 	"https://github.com/antosha417/nvim-lsp-file-operations",
-- 	"https://github.com/folke/lazydev.nvim",
-- "https://github.com/neovim/nvim-lspconfig",
-- })

-- vim.lsp.inline_completion.enable(true)
--
-- vim.keymap.set("i", "<Tab>", function()
-- 	if not vim.lsp.inline_completion.get() then return "<Tab>" end
-- end, { expr = true, desc = "Accept the current inline completion" })

-- require("lsp-file-operations").setup()
-- require("lazydev").setup({
-- 	library = {
-- 		{ path = "${3rd}/luv/library", words = { "vim%.uv" } },
-- 		{ path = "snacks.nvim", words = { "Snacks" } },
-- 	},
-- })
-- -- import cmp-nvim-lsp plugin
-- -- local cmp_nvim_lsp = require("cmp_nvim_lsp")
--
-- -- used to enable autocompletion (assign to every lsp server config)
-- -- local capabilities = cmp_nvim_lsp.default_capabilities()
-- -- capabilities.offsetEncoding = { "utf-16" }
--
-- Change the Diagnostic symbols in the sign column (gutter)
vim.diagnostic.config({
	signs = {
		text = {
			[vim.diagnostic.severity.ERROR] = " ",
			[vim.diagnostic.severity.WARN] = " ",
			[vim.diagnostic.severity.HINT] = "󰠠 ",
			[vim.diagnostic.severity.INFO] = " ",
		},
	},
})
