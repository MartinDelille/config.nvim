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

keymap.set("n", "<leader>yp", function() vim.fn.setreg("+", vim.fn.expand("%:p")) end, { desc = "Yank file path to clipboard" })
