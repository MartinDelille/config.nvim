vim.pack.add({
  "https://github.com/mfussenegger/nvim-dap",
  "https://github.com/Weissle/persistent-breakpoints.nvim",
  "https://github.com/mfussenegger/nvim-dap-python",
  "https://github.com/jay-babu/mason-nvim-dap.nvim",
  "https://github.com/igorlfs/nvim-dap-view",
})

local dap = require("dap")
require("persistent-breakpoints").setup({
  load_breakpoints_event = { "BufReadPost" },
})
local breakpoints = require("persistent-breakpoints.api")

require("dap-python").setup("uv")
-- https://igorlfs.github.io/nvim-dap-view/
local view = require("dap-view")
view.setup({
  switchbuf = "usetab,uselast",
  auto_toggle = true,
  virtual_text = {
    enabled = true,
    position = "eol",
  },
})

vim.keymap.set("n", "<leader>dB", function() view.jump_to_view("breakpoints") end, { desc = "Jump to breakpoints view" })
vim.keymap.set("n", "<leader>dT", function() view.jump_to_view("threads") end, { desc = "Jump to threads view" })
vim.keymap.set("n", "<leader>dS", function() view.jump_to_view("scopes") end, { desc = "Jump to scopes view" })
vim.keymap.set("n", "<leader>dr", function() dap.continue() end, { desc = "Start or continue the debugger" })
vim.keymap.set("n", "<leader>db", function() breakpoints.toggle_breakpoint() end, { desc = "Add a breakpoint at line" })
vim.keymap.set("n", "<F9>", function() breakpoints.toggle_breakpoint() end, { desc = "Add a breakpoint at line" })
vim.keymap.set("n", "<F5>", function() dap.continue() end, { desc = "Start or continue the debugger" })
vim.keymap.set("n", "<leader>di", function() dap.step_into() end, { desc = "Step Into" })
vim.keymap.set("n", "<F7>", function() dap.step_into() end, { desc = "Step Into" })
vim.keymap.set("n", "<leader>do", function() dap.step_over() end, { desc = "Step Over" })
vim.keymap.set("n", "<F8>", function() dap.step_over() end, { desc = "Step Over" })
vim.keymap.set("n", "<leader>dt", function() dap.terminate() end, { desc = "Terminate the debugging session" })
vim.keymap.set("n", "<leader>du", function() dap.step_out() end, { desc = "Step Out" })
vim.keymap.set("n", "<leader>dc", function() dap.run_to_cursor() end, { desc = "Continue to cursor" })
vim.keymap.set("n", "<F11>", function() dap.run_to_cursor() end, { desc = "Continue to cursor" })
vim.keymap.set({ "n", "x" }, "<leader>du", function() view.toggle() end, { desc = "Toggle DAP UI" })

vim.fn.sign_define("DapBreakpoint", { text = "🛑", texthl = "", linehl = "Substitute", numhl = "" })
vim.fn.sign_define("DapStopped", { text = "➡️", texthl = "", linehl = "", numhl = "" })

local cmake = require("cmake-tools")

local function get_executable()
  if cmake.is_cmake_project() then
    local path = cmake.get_launch_target_path()
    if path then return path end
  end

  local env_executable = vim.env.EXECUTABLE
  if env_executable and env_executable ~= "" then return env_executable end

  return vim.fn.input("Path to executable: ", vim.fn.getcwd() .. "/", "file")
end

local function has_cmake_target() return cmake.is_cmake_project() and cmake.get_launch_target() ~= nil end

local function get_arguments()
  if has_cmake_target() then return cmake.get_launch_args() end

  vim.cmd.rshada()
  local raw = vim.g.ARGUMENTS or ""

  if raw == "" then return {} end

  return vim.split(raw, "%s+", { trimempty = true })
end

vim.keymap.set("n", "<leader>ds", function()
  local current = get_arguments()

  vim.ui.input({
    prompt = "Arguments? ",
    default = table.concat(current, " "),
    completion = "file",
  }, function(input)
    if input == nil then return end

    local args = vim.split(input, "%s+", { trimempty = true })

    if has_cmake_target() then
      -- Equivalent to :CMakeLaunchArgs ...
      cmake.launch_args({ fargs = args })
    else
      -- Fallback for non-CMake projects
      vim.g.ARGUMENTS = input
      vim.cmd.wshada()
    end

    dap.continue()
  end)
end)

dap.adapters.codelldb = {
  type = "executable",
  command = "codelldb",
}
dap.configurations.cpp = {
  {
    name = "Launch file",
    type = "codelldb",
    request = "launch",
    program = get_executable,
    args = get_arguments,
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
