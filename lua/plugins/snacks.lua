return {
	"folke/snacks.nvim",
	priority = 1000,
	lazy = false,
	---@type snacks.Config
	opts = {
		bigfile = { enabled = true },
		dashboard = {
			enabled = true,

			preset = { ---@type snacks.dashboard.Item[]
				keys = {
					{ icon = " ", key = "f", desc = "Find File", action = function() Snacks.dashboard.pick("files") end },
					{ icon = " ", key = "n", desc = "New File", action = function() vim.cmd("ene | startinsert") end },
					{ icon = " ", key = "t", desc = "Find Text", action = function() Snacks.dashboard.pick("live_grep") end },
					{ icon = " ", key = "g", desc = "Copilot Chat", action = "<cmd>Lazy load codecompanion.nvim<CR><cmd>CodeCompanionChat<CR><cmd>only<CR>" },
					{ icon = " ", key = "r", desc = "Recent Files", action = function() Snacks.dashboard.pick("oldfiles") end },
					{ icon = " ", key = "c", desc = "Config", action = function() Snacks.dashboard.pick("files", { cwd = vim.fn.stdpath("config") }) end },
					{ icon = " ", key = "s", desc = "Restore Session", section = "session" },
					{ icon = "󰒲 ", key = "L", desc = "Lazy", action = function() vim.cmd("Lazy") end, enabled = package.loaded.lazy ~= nil },
					{ icon = " ", key = "q", desc = "Quit", action = function() vim.cmd("qa") end },
				},
				header = require("ascii.pacman_ghost"),
			},
		},
		explorer = { enabled = true },
		image = { enabled = true },
		indent = { enabled = true },
		input = { enabled = true },
		picker = {
			enabled = true,
			hidden = true,
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
	},
	keys = {
		-- Top Pickers
		{ "<leader><space>", function() Snacks.picker.smart() end, desc = "Smart Find Files" },
		{ "<leader>,", function() Snacks.picker.buffers() end, desc = "Buffers" },
		{ "<leader>/", function() Snacks.picker.grep() end, desc = "Grep" },
		{ "<leader>:", function() Snacks.picker.command_history() end, desc = "Command History" },
		{ "<leader>e", function() Snacks.explorer() end, desc = "File Explorer" },
		-- find
		{ "<leader>fr", function() Snacks.picker.recent() end, desc = "Recent" },
		-- git
		{ "<leader>gbr", function() Snacks.picker.git_branches() end, desc = "Git Branches" },
		{ "<leader>gbl", function() Snacks.git.blame_line() end, desc = "Git Blame Line" },
		{ "<leader>gl", function() Snacks.picker.git_log() end, desc = "Git Log" },
		{ "<leader>gL", function() Snacks.picker.git_log_line() end, desc = "Git Log Line" },
		{ "<leader>gs", function() Snacks.picker.git_status() end, desc = "Git Status" },
		{ "<leader>gS", function() Snacks.picker.git_stash() end, desc = "Git Stash" },
		{ "<leader>gd", function() Snacks.picker.git_diff() end, desc = "Git Diff (Hunks)" },
		{ "<leader>gf", function() Snacks.picker.git_log_file() end, desc = "Git Log File" },
		-- search
		{ '<leader>s"', function() Snacks.picker.registers() end, desc = "Registers" },
		{ "<leader>s/", function() Snacks.picker.search_history() end, desc = "Search History" },
		{ "<leader>sc", function() Snacks.dashboard.pick("files", { cwd = vim.fn.stdpath("config") }) end, desc = "Configuration" },
		{ "<leader>sd", function() Snacks.picker.diagnostics() end, desc = "Diagnostics" },
		{ "<leader>sq", function() Snacks.picker.qflist() end, desc = "Quickfix List" },
		{ "<leader>su", function() Snacks.picker.undo() end, desc = "Undo History" },
		{ "<leader>th", function() Snacks.picker.colorschemes() end, desc = "Colorschemes" },
		{ "<leader>sD", function() Snacks.picker.diagnostics_buffer() end, desc = "Buffer Diagnostics" },
		{ "<leader>sk", function() Snacks.picker.keymaps() end, desc = "Keymaps" },
		{ "<leader>sl", function() Snacks.picker.loclist() end, desc = "Location List" },
		-- LSP
		{ "gd", function() Snacks.picker.lsp_definitions() end, desc = "Goto Definition" },
		{ "gD", function() Snacks.picker.lsp_declarations() end, desc = "Goto Declaration" },
		{ "gR", function() Snacks.picker.lsp_references() end, nowait = true, desc = "References" },
		{ "gI", function() Snacks.picker.lsp_implementations() end, desc = "Goto Implementation" },
		{ "gy", function() Snacks.picker.lsp_type_definitions() end, desc = "Goto T[y]pe Definition" },
		{ "<leader>ss", function() Snacks.picker.lsp_symbols() end, desc = "LSP Symbols" },
		{ "<leader>sS", function() Snacks.picker.lsp_workspace_symbols() end, desc = "LSP Workspace Symbols" },
		-- Notifications
		{ "<leader>nn", function() Snacks.notifier.show_history() end, desc = "Notification History" },
		{ "<leader>mm", function() Snacks.terminal.open("make", { interactive = false, win = { position = "bottom" } }) end, desc = "Run Make in Terminal" },
		{ "<leader>mt", function() Snacks.terminal.open() end, desc = "Open Terminal" },
	},
}
