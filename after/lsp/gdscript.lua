return {
	on_attach = function(client, _)
		-- Check if client failed to initialize
		if client.is_stopped() then
			vim.notify("GDScript LSP: Client failed to start. Does Godot handle stdio ?", vim.log.levels.ERROR)
			return
		end

		vim.notify("GDScript LSP: Connected successfully", vim.log.levels.INFO)
	end,
	on_exit = function(code, signal, _)
		if code ~= 0 then vim.notify(string.format("GDScript LSP: Exited unexpectedly (code: %s, signal: %s)", code, signal), vim.log.levels.WARN) end
	end,
}
