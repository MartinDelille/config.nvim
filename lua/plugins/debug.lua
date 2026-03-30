vim.pack.add({
	"https://github.com/mfussenegger/nvim-dap",
	"https://github.com/Weissle/persistent-breakpoints.nvim",
	"https://github.com/mfussenegger/nvim-dap-python",
	"https://github.com/jay-babu/mason-nvim-dap.nvim",
	{ src = "https://github.com/igorlfs/nvim-dap-view", version = vim.version.range("1.0.0 - 2.0.0") },
	"https://github.com/theHamsta/nvim-dap-virtual-text",
})

local dap = require("dap")
require("persistent-breakpoints").setup({
	load_breakpoints_event = { "BufReadPost" },
})
local breakpoints = require("persistent-breakpoints.api")

require("mason-nvim-dap").setup({ handlers = {} })
require("dap-python").setup("uv")
local view = require("dap-view")
view.setup({
	switchbuf = "useopen",
	auto_toggle = true,
})
require("nvim-dap-virtual-text").setup({
	virt_text_pos = "inline",
})

vim.keymap.set("n", "<leader>db", function() breakpoints.toggle_breakpoint() end, { desc = "Add a breakpoint at line" })
vim.keymap.set("n", "<F9>", function() breakpoints.toggle_breakpoint() end, { desc = "Add a breakpoint at line" })
vim.keymap.set("n", "<leader>dr", function() dap.continue() end, { desc = "Start or continue the debugger" })
vim.keymap.set("n", "<F5>", function() dap.continue() end, { desc = "Start or continue the debugger" })
vim.keymap.set("n", "<leader>di", function() dap.step_into() end, { desc = "Step Into" })
vim.keymap.set("n", "<leader>do", function() dap.step_over() end, { desc = "Step Over" })
vim.keymap.set("n", "<F8>", function() dap.step_over() end, { desc = "Step Over" })
vim.keymap.set("n", "<leader>dt", function() dap.terminate() end, { desc = "Terminate the debugging session" })
vim.keymap.set("n", "<leader>du", function() dap.step_out() end, { desc = "Step Out" })
vim.keymap.set("n", "<leader>dc", function() dap.run_to_cursor() end, { desc = "Continue to cursor" })
vim.keymap.set("n", "<F11>", function() dap.run_to_cursor() end, { desc = "Continue to cursor" })
vim.keymap.set({ "n", "x" }, "<leader>du", function() view.toggle() end, { desc = "Toggle DAP UI" })

vim.fn.sign_define("DapBreakpoint", { text = "🛑", texthl = "", linehl = "", numhl = "" })
vim.fn.sign_define("DapStopped", { text = "➡️", texthl = "", linehl = "debugPC", numhl = "" })

dap.adapters.codelldb = {
	type = "server",
	port = "${port}",
	executable = {
		command = "codelldb",
		args = { "--port", "${port}" },
	},
}
dap.configurations.cpp = {
	{
		name = "Launch file",
		type = "codelldb",
		request = "launch",
		program = function()
			local executable = os.getenv("EXECUTABLE")
			vim.notify(string.format("EXECUTABLE: %s", executable or "nil"))
			if executable then
				return executable
			else
				return vim.fn.input("Path to executable: ", vim.fn.getcwd() .. "/", "file")
			end
		end,
		args = function()
			local arguments = os.getenv("ARGUMENTS")
			vim.notify(string.format("ARGUMENTS: %s", arguments or "nil"))
			if arguments then return vim.split(arguments, " ") end
			return {}
		end,
		cwd = "${workspaceFolder}",
		stopOnEntry = false,
		preRunCommands = {
			"breakpoint name configure --disable cpp_exception",
		},
	},
}
dap.adapters["pwa-node"] = {
	id = "pwa-node",
	type = "server",
	host = "localhost",
	port = 8123,
	executable = {
		command = "js-debug-adapter",
		args = {
			"8123",
		},
	},
}
dap.adapters["pwa-chrome"] = dap.adapters["pwa-node"]

dap.configurations.javascript = {
	{
		type = "pwa-node",
		request = "launch",
		name = "Electron Main",
		runtimeExecutable = "${workspaceFolder}/node_modules/.bin/electron",
		args = { ".", "--remote-debugging-port=9222" },
		cwd = "${workspaceFolder}",
		sourceMaps = true,
		protocol = "inspector",
		console = "integratedTerminal",
		resolveSourceMapLocations = {
			"${workspaceFolder}/**",
			"!**/node_modules/**",
		},
	},
	{
		type = "pwa-chrome",
		request = "attach",
		name = "Electron Renderer",
		port = 9222,
		webRoot = "${workspaceFolder}",
		sourceMaps = true,
		protocol = "inspector",
	},
}
