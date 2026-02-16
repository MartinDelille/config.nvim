local utils = require("utils")

local function do_make(opts)
	utils.write_if_writable()
	local term = Snacks.terminal.open("make", {
		interactive = false,
		win = { position = "right" },
		auto_close = opts and opts.auto_close or true,
	})
	-- vim.print(vim.inspect(term))
	vim.api.nvim_buf_call(term.scratch_buf, function() vim.cmd("setlocal buflisted") end)
	utils.move_cursor_to_end({ buf = term.scratch_buf, win = term.win })
end

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
					{
						icon = " ",
						key = "g",
						desc = "Copilot Chat",
						action = function()
							require("codecompanion").chat({})
							vim.cmd("only")
						end,
					},
					{ icon = " ", key = "r", desc = "Recent Files", action = function() Snacks.dashboard.pick("oldfiles") end },
					{ icon = " ", key = "c", desc = "Config", action = function() Snacks.dashboard.pick("files", { cwd = vim.fn.stdpath("config") }) end },
					{ icon = " ", key = "s", desc = "Restore Session", section = "session" },
					{ icon = "󰒲 ", key = "L", desc = "Lazy", action = function() vim.cmd("Lazy") end, enabled = package.loaded.lazy ~= nil },
					{ icon = " ", key = "q", desc = "Quit", action = function() vim.cmd("qa") end },
				},
				header = require("ascii.pacman_ghost"),
			},
			sections = {
				-- { section = "header" },
				{
					section = "terminal",
					cmd = "/Users/martindelille/dev/clone/pokemon-colorscripts-go/pokemon-colorscripts-go --no-title",
					random = 10,
					pane = 2,
					indent = 4,
					height = 20,
				},
				{ section = "keys", gap = 1, padding = 1 },
				{ section = "startup" },
			},
		},
		explorer = { enabled = true },
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
		{
			"<leader>mm",
			function() do_make() end,
			desc = "Run Make in Terminal",
		},
		{
			"<leader>mx",
			function() do_make({ auto_close = true }) end,
			desc = "Run Make and Auto-Close Terminal on Success",
		},
		{
			"<leader>ms",
			function()
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

				Snacks.picker.select(items, { prompt = "Make Targets" }, function(item)
					if type(item) ~= "string" or item == "" then return end
					vim.cmd("write")
					Snacks.terminal.open("make " .. item, {
						interactive = false,
						win = { position = "right" },
					})
				end)
			end,
			desc = "Select and Run Make Target",
		},
		{ "<leader>mt", function() Snacks.terminal.open() end, desc = "Open Terminal" },
	},
}
