return {
	"mfussenegger/nvim-dap",
	keys = {
		{ "<leader>db", mode = "n", desc = "Add a breakpoint at line", function() require("dap").toggle_breakpoint() end },
		{ "<F9>", mode = "n", desc = "Add a breakpoint at line", function() require("dap").toggle_breakpoint() end },
		{ "<leader>dr", mode = "n", desc = "Start or continue the debugger", function() require("dap").continue() end },
		{ "<F5>", mode = "n", desc = "Start or continue the debugger", function() require("dap").continue() end },
		{ "<leader>di", mode = "n", desc = "Step Into", function() require("dap").step_into() end },
		{ "<leader>do", mode = "n", desc = "Step Over", function() require("dap").step_over() end },
		{ "<F8>", mode = "n", desc = "Step Over", function() require("dap").step_over() end },
		{ "<leader>dt", mode = "n", desc = "Terminate the debugging session", function() require("dap").terminate() end },
		{ "<leader>du", mode = "n", desc = "Step Out", function() require("dap").step_out() end },
		{ "<leader>dc", mode = "n", desc = "Continue to cursor", function() require("dap").run_to_cursor() end },
		{ "<F11>", mode = "n", desc = "Continue to cursor", function() require("dap").run_to_cursor() end },
	},
	config = function()
		local dap = require("dap")
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
	end,
}
