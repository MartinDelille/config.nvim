return {
	"neovim/nvim-lspconfig",
	event = { "BufReadPre", "BufNewFile" },
	dependencies = {
		"hrsh7th/cmp-nvim-lsp",
		{ "antosha417/nvim-lsp-file-operations", config = true },
		{
			"folke/lazydev.nvim",
			opts = {
				library = {
					{ path = "${3rd}/luv/library", words = { "vim%.uv" } },
					{ path = "snacks.nvim", words = { "Snacks" } },
				},
			},
		},
	},
	config = function()
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

		vim.lsp.config.gdscript = {
			cmd = {
				"/Users/martindelille/dev/godot/engine/bin/godot.macos.editor.dev.arm64",
				"--lsp",
				"--log-file",
				"/Users/martindelille/dev/godot/engine/debug.log",
			},
			-- filetypes = { "gd", "gdscript", "gdscript3" },
			-- root_dir = vim.fs.dirname(vim.fs.find({ "project.godot", ".git" }, { upward = true })[1]),
			-- capabilities = capabilities,
			on_attach = function(client, _)
				-- Check if client failed to initialize
				if client.is_stopped() then
					vim.notify("GDScript LSP: Client failed to start. port %s?", vim.log.levels.ERROR)
					return
				end

				vim.notify("GDScript LSP: Connected successfully", vim.log.levels.INFO)
			end,
		}
		vim.lsp.enable("gdscript")
		vim.lsp.enable("qmlls")
		-- vim.api.nvim_create_autocmd("LspAttach", {
		-- 	callback = function(args)
		-- 		local client = vim.lsp.get_client_by_id(args.data.client_id)
		-- 		if not client then return end

		-- if client.supports_method("textDocument/formatting") then
		-- 	vim.api.nvim_create_autocmd("BufWritePre", {
		-- 		buffer = args.buf,
		-- callback = function() vim.lsp.buf.format({ bufnr = args.buf, id = client.id }) end,
		-- })
		-- end
		-- 	end,
		-- })
	end,
}
