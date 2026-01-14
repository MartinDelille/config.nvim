-- set leader key to space
vim.g.mapleader = " "

local keymap = vim.keymap -- for conciseness

---------------------
-- General Keymaps -------------------

-- use jk to exit insert mode
keymap.set("i", "jk", "<ESC>", { desc = "Exit insert mode with jk" })

-- increment/decrement numbers
keymap.set("n", "<leader>+", "<C-a>", { desc = "Increment number" }) -- increment
keymap.set("n", "<leader>-", "<C-x>", { desc = "Decrement number" }) -- decrement

-- buffer management
keymap.set("n", "<tab>", function() vim.cmd.bnext() end, { desc = "Go to next buffer" })
keymap.set("n", "<S-tab>", function() vim.cmd.bprevious() end, { desc = "Go to previous buffer" })

-- Update lazy plugins
keymap.set("n", "<leader>lz", function() vim.cmd.Lazy("update") end, { desc = "Update lazy plugins" })

-- Run make
-- keymap.set("n", "<leader>mm", function()
-- vim.cmd.make()
-- vim.cmd("tabnew | read !make")
-- end, { desc = "Run make" })

keymap.set("n", "<leader>yp", function() vim.fn.setreg("+", vim.fn.expand("%:p")) end, { desc = "Yank file path to clipboard" })

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
