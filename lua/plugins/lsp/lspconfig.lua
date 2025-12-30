return {
	"neovim/nvim-lspconfig",
	event = { "BufReadPre", "BufNewFile" },
	dependencies = {
		"hrsh7th/cmp-nvim-lsp",
		{ "antosha417/nvim-lsp-file-operations", config = true },
		{ "folke/neodev.nvim", opts = {} },
	},
	config = function()
		vim.lsp.config("lua_ls", {
			settings = {
				Lua = {
					diagnostics = {
						globals = { "vim" },
					},
				},
			},
		})

		-- import mason_lspconfig plugin
		local mason_lspconfig = require("mason-lspconfig")

		-- import cmp-nvim-lsp plugin
		local cmp_nvim_lsp = require("cmp_nvim_lsp")

		-- used to enable autocompletion (assign to every lsp server config)
		local capabilities = cmp_nvim_lsp.default_capabilities()
		capabilities.offsetEncoding = { "utf-16" }

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

		mason_lspconfig.setup()

		vim.keymap.set("n", "<leader>yd", function()
			local diag = vim.diagnostic.get(0, { lnum = vim.fn.line(".") - 1 })[1]
			if diag then
				local code = diag.code or (diag.user_data and diag.user_data.lsp and diag.user_data.lsp.code) or "N/A"
				local source = diag.source or (diag.user_data and diag.user_data.lsp and diag.user_data.lsp.source) or "N/A"
				local lnum = (diag.lnum or 0) + 1
				local col = (diag.col or 0) + 1
				local filename = vim.api.nvim_buf_get_name(diag.bufnr or 0)
				local location = string.format("%s:%d:%d", filename ~= "" and vim.fn.fnamemodify(filename, ":.") or "[No Name]", lnum, col)
				local msg = diag.message or ""
				local result = string.format("[code: %s] [source: %s] [location: %s]\n%s", code, source, location, msg)
				vim.fn.setreg("+", result)
				print("Diagnostic yanked")
			end
		end, { desc = "Yank diagnostic under cursor" })
	end,
}
