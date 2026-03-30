vim.pack.add({ "https://github.com/sontungexpt/url-open" })

local url_open = require("url-open")

url_open.setup({
	open_only_when_cursor_on_url = false,
})
vim.keymap.set("n", "<leader>gx", function() vim.cmd.URLOpenUnderCursor() end, { desc = "Open URL under cursor" })
