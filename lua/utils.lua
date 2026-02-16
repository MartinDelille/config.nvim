local M = {}

function M.write_if_writable(buf)
	buf = buf or vim.api.nvim_get_current_buf()
	local bufname = vim.api.nvim_buf_get_name(buf)
	local modifiable = vim.bo[buf].modifiable
	local readonly = vim.bo[buf].readonly
	local buftype = vim.bo[buf].buftype

	if bufname ~= "" then
		if modifiable and not readonly and buftype == "" then vim.cmd("write") end
	end
end

function M.move_cursor_to_end(opts)
	local buf = opts and opts.buf or vim.api.nvim_get_current_buf()
	local win = opts and opts.win or 0
	local last_line = vim.api.nvim_buf_line_count(buf)
	local last_col = #vim.api.nvim_buf_get_lines(buf, last_line - 1, last_line, false)[1] or 0
	vim.print("Moving cursor to end of buffer: line " .. last_line .. ", col " .. last_col)
	vim.api.nvim_win_set_cursor(win, { last_line, last_col })
end

return M
