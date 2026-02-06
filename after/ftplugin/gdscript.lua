-- Godot convention: tabs with width of 4
vim.opt_local.tabstop = 4
vim.opt_local.shiftwidth = 4
vim.opt_local.softtabstop = 4
vim.opt_local.expandtab = false

-- Godot executable path
-- local godot_executable = "/Applications/Godot.app/Contents/MacOS/Godot"
local godot_executable = "/Users/martindelille/dev/godot/engine/bin/godot.macos.editor.arm64"

-- Track last scene run
local last_scene = nil

-- Helper: find project.godot and return project path
local function find_project()
	local project_file = vim.fn.findfile("project.godot", ".;")
	if project_file == "" then return nil, nil end
	return project_file, vim.fn.fnamemodify(project_file, ":h")
end

-- Helper: get main scene from project.godot
local function get_main_scene(project_file)
	for _, line in ipairs(vim.fn.readfile(project_file)) do
		local match = line:match('^run/main_scene="res://(.+)"')
		if match then return match end
	end
	return nil
end

-- Helper: run a scene
local function run_scene(scene)
	local project_file, project_path = find_project()
	if not project_path then
		vim.notify("No project.godot found", vim.log.levels.ERROR)
		return
	end

	local target = scene
	if not target or target == "" then target = get_main_scene(project_file) end

	if target then last_scene = target end

	local cmd = { godot_executable, "--path", project_path }
	if target and target ~= "" then table.insert(cmd, target) end

	vim.fn.jobstart(cmd, { detach = true })
	vim.notify("Running: " .. (target or "main scene"), vim.log.levels.INFO)
end

-- :GodotRun [scene] - Run main scene or specified scene
vim.api.nvim_buf_create_user_command(0, "GodotRun", function(opts) run_scene(opts.args ~= "" and opts.args or nil) end, {
	nargs = "?",
	complete = function()
		local _, project_path = find_project()
		if not project_path then return {} end
		local scenes = vim.fn.globpath(project_path, "**/*.tscn", false, true)
		-- Make paths relative to project
		for i, scene in ipairs(scenes) do
			scenes[i] = scene:gsub("^" .. vim.pesc(project_path) .. "/", "")
		end
		return scenes
	end,
})

-- :GodotRunCurrent - Run scene for current script
vim.api.nvim_buf_create_user_command(0, "GodotRunCurrent", function()
	local scene = vim.fn.expand("%:r") .. ".tscn"
	run_scene(scene)
end, {})

-- :GodotRunLast - Re-run the last scene
vim.api.nvim_buf_create_user_command(0, "GodotRunLast", function()
	if not last_scene then
		vim.notify("No scene was run yet", vim.log.levels.WARN)
		return
	end
	run_scene(last_scene)
end, {})
