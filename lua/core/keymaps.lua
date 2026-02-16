local utils = require("utils")

-- set leader key to space
vim.g.mapleader = " "

local keymap = vim.keymap -- for conciseness

---------------------
-- General Keymaps -------------------

-- use jk to exit insert mode
keymap.set("i", "jk", "<ESC>", { desc = "Exit insert mode with jk" })

-- buffer management
keymap.set("n", "<tab>", function() vim.cmd.bnext() end, { desc = "Go to next buffer" })
keymap.set("n", "<S-tab>", function() vim.cmd.bprevious() end, { desc = "Go to previous buffer" })

-- Update lazy plugins
keymap.set("n", "<leader>lz", function() vim.cmd.Lazy("update") end, { desc = "Update lazy plugins" })

keymap.set("n", "<leader>yp", function() vim.fn.setreg("+", vim.fn.expand("%:p")) end, { desc = "Yank file path to clipboard" })

keymap.set("n", "<leader>yd", function()
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
		vim.notify("Diagnostic yanked")
	end
end, { desc = "Yank diagnostic under cursor" })

vim.keymap.set("n", "<leader>mq", function()
	utils.write_if_writable()
	vim.fn.setqflist({}, "r") -- reset quickfix list
	vim.cmd("make")
end, { desc = "Run Make" })

vim.keymap.set("n", "<leader>wo", function() vim.cmd("write") end, { desc = "Write the current buffer" })
vim.keymap.set("n", "<leader>xx", function()
	local buf = vim.api.nvim_get_current_buf()
	utils.write_if_writable(buf)
	local config_table = {
		["lua"] = { cmd = "luafile %", mode = "command" },
		["sh"] = { cmd = "bash", mode = "terminal" },
	}
	local ft = vim.bo[buf].filetype
	local path = vim.api.nvim_buf_get_name(buf)
	local filename = vim.fn.fnamemodify(path, ":t")
	local config = config_table[ft]
	if config == nil then
		local file_table = {
			[".tmux.conf"] = { cmd = "!tmux source-file", mode = "command" },
		}
		config = file_table[filename]
	end

	if config then
		if config.mode == "terminal" then
			local term = Snacks.terminal.open(config.cmd .. " " .. path, {
				win = { position = "right" },
				auto_close = true,
			})
		else
			vim.cmd(config.cmd)
		end
	end
end, { desc = "Run the current buffer" })
vim.keymap.set("t", "<esc><esc>", "<C-\\><C-n>", { desc = "Exit terminal mode with double Esc" })
