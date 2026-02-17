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
vim.keymap.set("n", "<leader>wa", function() vim.cmd("wall") end, { desc = "Write all buffer" })
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

local function enable_resize_mode()
	local opts = { noremap = true, silent = true, buffer = 0 }
	vim.notify("Resize mode: j/k/l/h to resize, q or <Esc> to quit", vim.log.levels.INFO)

	-- Set buffer-local mappings for resize mode
	vim.keymap.set("n", "j", function() vim.cmd("resize -2") end, opts)
	vim.keymap.set("n", "k", function() vim.cmd("resize +2") end, opts)
	vim.keymap.set("n", "l", function() vim.cmd("vertical resize -5") end, opts)
	vim.keymap.set("n", "h", function() vim.cmd("vertical resize +5") end, opts)
	vim.keymap.set("n", "q", function() disable_resize_mode() end, opts)
	vim.keymap.set("n", "<Esc>", function() disable_resize_mode() end, opts)
end

function disable_resize_mode()
	-- Remove the buffer-local mappings
	vim.keymap.del("n", "j", { buffer = 0 })
	vim.keymap.del("n", "k", { buffer = 0 })
	vim.keymap.del("n", "l", { buffer = 0 })
	vim.keymap.del("n", "h", { buffer = 0 })
	vim.keymap.del("n", "q", { buffer = 0 })
	vim.keymap.del("n", "<Esc>", { buffer = 0 })
	vim.notify("Resize mode exited", vim.log.levels.INFO)
end

vim.keymap.set("n", "<leader>wr", enable_resize_mode, { noremap = true, silent = true })
