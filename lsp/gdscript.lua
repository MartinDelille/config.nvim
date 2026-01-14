local port = os.getenv("GDScript_Port") or "6005"
return {
	on_attach = function(client, _)
		-- Check if client failed to initialize
		if client.is_stopped() then
			vim.notify(string.format("GDScript LSP: Client failed to start. Is Godot running on port %s?", port), vim.log.levels.ERROR)
			return
		end

		vim.notify(string.format("GDScript LSP: Connected successfully on port %s", port), vim.log.levels.INFO)
	end,
	on_exit = function(code, signal, _)
		if code ~= 0 then vim.notify(string.format("GDScript LSP: Exited unexpectedly (code: %s, signal: %s)", code, signal), vim.log.levels.WARN) end
	end,
}
