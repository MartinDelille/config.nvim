vim.pack.add({ "https://github.com/folke/snacks.nvim" })

local snacks = require("snacks")
local utils = require("utils")

local function do_make(opts)
	utils.write_if_writable()
	vim.cmd.rshada()
	local term = snacks.terminal.open("make " .. vim.g.MAKE_TARGET, {
		interactive = false,
		win = { position = "right" },
		auto_close = opts and opts.auto_close or true,
	})
	utils.move_cursor_to_end({ buf = term.scratch_buf, win = term.win })
end

snacks.setup({
	bigfile = { enabled = true },
	dashboard = {
		sections = {
			{ section = "header" },
			{ section = "keys", gap = 1, padding = 1 },
		},
		preset = {
			keys = {
				{ icon = " ", key = "f", desc = "Find File", action = function() snacks.dashboard.pick("files") end },
				{ icon = " ", key = "n", desc = "New File", action = function() vim.cmd("ene | startinsert") end },
				{ icon = " ", key = "t", desc = "Find Text", action = function() snacks.dashboard.pick("live_grep") end },
				{
					icon = " ",
					key = "g",
					desc = "Copilot Chat",
					action = function()
						require("codecompanion").chat({})
						vim.cmd("only")
					end,
				},
				{ icon = " ", key = "r", desc = "Recent Files", action = function() snacks.dashboard.pick("oldfiles") end },
				{ icon = " ", key = "c", desc = "Config", action = function() snacks.dashboard.pick("files", { cwd = vim.fn.stdpath("config") }) end },
				{ icon = " ", key = "s", desc = "Restore Session", section = "session" },
				{ icon = " ", key = "q", desc = "Quit", action = function() vim.cmd("qa") end },
			},
			header = require("ascii.pacman_ghost"),
		},
	},
	image = { enabled = true },
	indent = { enabled = true },
	input = { enabled = true },
	picker = {
		enabled = true,
		hidden = true,
		exclude = {
			"**/.git/*",
			"**/node_modules/*",
		},
		sources = {
			colorschemes = {
				confirm = function(picker, item)
					local source = require("snacks.picker.config.sources").colorschemes
					source.confirm(picker, item)
					save_colorscheme(item.text)
				end,
			},
		},
	},
	notifier = { enabled = true },
	quickfile = { enabled = true },
	scope = { enabled = true },
	scroll = { enabled = true },
	statuscolumn = { enabled = true },
	words = { enabled = true },
	terminal = {},
})

-- 		-- Top Pickers
vim.keymap.set("n", "<leader><space>", function() snacks.picker.smart() end, { desc = "Smart Find Files" })
vim.keymap.set("n", "<leader>,", function() snacks.picker.buffers() end, { desc = "Buffers" })
vim.keymap.set("n", "<leader>/", function() snacks.picker.grep() end, { desc = "Live Grep" })
vim.keymap.set("n", "<leader>:", function() snacks.picker.command_history() end, { desc = "Command History" })
vim.keymap.set("n", "<leader>e", function() snacks.explorer() end, { desc = "File Explorer" })
-- git
vim.keymap.set("n", "<leader>gbr", function() snacks.picker.git_branches() end, { desc = "Git Branches" })
vim.keymap.set("n", "<leader>gbl", function() snacks.git.blame_line() end, { desc = "Git Blame Line" })
vim.keymap.set("n", "<leader>gl", function() snacks.picker.git_log() end, { desc = "Git Log" })
vim.keymap.set("n", "<leader>gL", function() snacks.picker.git_log_line() end, { desc = "Git Log Line" })
vim.keymap.set("n", "<leader>gs", function() snacks.picker.git_status() end, { desc = "Git Status" })
vim.keymap.set("n", "<leader>gS", function() snacks.picker.git_stash() end, { desc = "Git Stash" })
vim.keymap.set("n", "<leader>gd", function() snacks.picker.git_diff() end, { desc = "Git Diff (Hunks)" })
vim.keymap.set("n", "<leader>gf", function() snacks.picker.git_log_file() end, { desc = "Git Log File" })
-- search
vim.keymap.set("n", "<leader>fr", function() snacks.picker.recent() end, { desc = "Recent" })
vim.keymap.set("n", '<leader>s"', function() snacks.picker.registers() end, { desc = "Registers" })
vim.keymap.set("n", "<leader>s/", function() snacks.picker.search_history() end, { desc = "Search History" })
vim.keymap.set("n", "<leader>sc", function() snacks.dashboard.pick("files", { cwd = vim.fn.stdpath("config") }) end, { desc = "Configuration" })
vim.keymap.set("n", "<leader>sd", function() snacks.picker.diagnostics() end, { desc = "Diagnostics" })
vim.keymap.set("n", "<leader>sq", function() snacks.picker.qflist() end, { desc = "Quickfix List" })
vim.keymap.set("n", "<leader>su", function() snacks.picker.undo() end, { desc = "Undo History" })
vim.keymap.set("n", "<leader>th", function() snacks.picker.colorschemes() end, { desc = "Colorschemes" })
vim.keymap.set("n", "<leader>sD", function() snacks.picker.diagnostics_buffer() end, { desc = "Buffer Diagnostics" })
vim.keymap.set("n", "<leader>sk", function() snacks.picker.keymaps() end, { desc = "Keymaps" })
vim.keymap.set("n", "<leader>sl", function() snacks.picker.loclist() end, { desc = "Location List" })
-- LSP
vim.keymap.set("n", "gd", function() snacks.picker.lsp_definitions() end, { desc = "Goto Definition" })
vim.keymap.set("n", "gD", function() snacks.picker.lsp_declarations() end, { desc = "Goto Declaration" })
vim.keymap.set("n", "gR", function() snacks.picker.lsp_references() end, { desc = "References" })
vim.keymap.set("n", "gI", function() snacks.picker.lsp_implementations() end, { desc = "Goto Implementation" })
vim.keymap.set("n", "gy", function() snacks.picker.lsp_type_definitions() end, { desc = "Goto T[y]pe Definition" })
vim.keymap.set("n", "<leader>ss", function() snacks.picker.lsp_symbols() end, { desc = "LSP Symbols" })
vim.keymap.set("n", "<leader>sS", function() snacks.picker.lsp_workspace_symbols() end, { desc = "LSP Workspace Symbols" })
-- Notifications
vim.keymap.set("n", "<leader>nn", function() snacks.notifier.show_history() end, { desc = "Notification History" })
vim.keymap.set("n", "<leader>mm", function() do_make() end, { desc = "Run Make in Terminal" })
vim.keymap.set("n", "<leader>ms", function()
	utils.write_if_writable()
	-- Parse Makefile for targets
	local makefile = "Makefile"
	local f = io.open(makefile, "r")
	if not f then
		vim.notify("Makefile not found in current directory", vim.log.levels.WARN)
		return
	end
	f:close()

	local targets = {}
	for line in io.lines(makefile) do
		local target = line:match("^([%w-_%.]+):")
		if target and target ~= ".PHONY" then table.insert(targets, target) end
	end
	if #targets == 0 then
		vim.notify("No make targets found", vim.log.levels.WARN)
		return
	end

	local items = {}
	for _, t in ipairs(targets) do
		table.insert(items, t)
	end

	snacks.picker.select(items, { prompt = "Make Targets" }, function(item)
		if type(item) ~= "string" or item == "" then return end
		vim.g.MAKE_TARGET = item
		vim.cmd.wshada()
		do_make()
	end)
end, { desc = "Select and Run Make Target" })
vim.keymap.set("n", "<leader>mt", function() snacks.terminal.open() end, { desc = "Open Terminal" })
