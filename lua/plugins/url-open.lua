return {
	"sontungexpt/url-open",
	cmd = "URLOpenUnderCursor",
	keys = {
		{ "<leader>gx", function() vim.cmd.URLOpenUnderCursor() end, desc = "Open URL under cursor" },
	},
	open_only_when_cursor_on_url = false,
	config = function()
		local status_ok, url_open = pcall(require, "url-open")
		if not status_ok then return end

		url_open.setup({})
	end,
}
