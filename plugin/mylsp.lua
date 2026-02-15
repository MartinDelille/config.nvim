if false then
	local client = vim.lsp.start({
		name = "educational lsp",
		cmd = {
			-- "./lsp.sh",
			"/Users/martindelille/dev/godot/engine/bin/godot.macos.editor.dev.arm64",
			"--lsp",
			"--headless",
			"--log-file",
			"lsp.log",
			"/Users/martindelille/dev/godot/bacasable",
			-- "/Users/martindelille/dev/clone/educationalsp/educationalsp",
			-- "/Users/martindelille/dev/godot/engine/lsp.sh",
			-- "python3", "/Users/martindelille/dev/godot/engine/lsp.py"
		},
		-- on_attach = function(client, _) vim.notify("GDScript LSP: Connected successfully", vim.log.levels.INFO) end,
	})

	if not client then
		vim.notify("Faileiiid to start LSP client", vim.log.levels.ERROR)
	else
		vim.notify("LSP client started successfully", vim.log.levels.INFO)
	end
end
