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
  virtual_text = true,
  signs = {
    text = {
      [vim.diagnostic.severity.ERROR] = " ",
      [vim.diagnostic.severity.WARN] = " ",
      [vim.diagnostic.severity.HINT] = "󰠠 ",
      [vim.diagnostic.severity.INFO] = " ",
    },
  },
})

vim.lsp.enable("gdscript")
vim.lsp.enable("qmlls")

-- vim.api.nvim_create_autocmd("LspAttach", {
--   group = vim.api.nvim_create_augroup("my.lsp", {}),
--   callback = function(ev)
--     local client = assert(vim.lsp.get_client_by_id(ev.data.client_id))
--     if client:supports_method("textDocument/implementation") then
--       -- Create a keymap for vim.lsp.buf.implementation ...
--     end
--
--     -- Enable auto-completion. Note: Use CTRL-Y to select an item. |complete_CTRL-Y|
--     if client:supports_method("textDocument/completion") then
--       -- Optional: trigger autocompletion on EVERY keypress. May be slow!
--       local chars = {}
--       for i = 32, 126 do
--         table.insert(chars, string.char(i))
--       end
--       client.server_capabilities.completionProvider.triggerCharacters = chars
--
--       -- vim.lsp.completion.enable(true, client.id, ev.buf, { autotrigger = true })
--     end
--
--     -- Auto-format ("lint") on save.
--     -- Usually not needed if server supports "textDocument/willSaveWaitUntil".
--     if not client:supports_method("textDocument/willSaveWaitUntil") and client:supports_method("textDocument/formatting") then
--       vim.api.nvim_create_autocmd("BufWritePre", {
--         group = vim.api.nvim_create_augroup("my.lsp", { clear = false }),
--         buffer = ev.buf,
--         callback = function() vim.lsp.buf.format({ bufnr = ev.buf, id = client.id, timeout_ms = 1000 }) end,
--       })
--     end
--   end,
-- })
-- vim.cmd("set completeopt+=noselect")

vim.keymap.set("n", "<leader>oh", function()
  local client = vim.lsp.get_clients({ bufnr = 0, name = "clangd" })[1]

  if not client then
    vim.notify("clangd is not attached", vim.log.levels.WARN)
    return
  end

  local params = {
    uri = vim.uri_from_bufnr(0),
  }

  local response = client:request_sync("textDocument/switchSourceHeader", params, 1000, 0)

  if response and response.result then vim.cmd.edit(vim.uri_to_fname(response.result)) end
end, { desc = "Switch C++ source/header" })
