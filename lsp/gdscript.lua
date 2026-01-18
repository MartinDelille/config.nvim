-- local port = os.getenv("GDScript_Port") or "6005"
--
-- local function connect_gdscript()
-- 	local ok, cmd = pcall(vim.lsp.rpc.connect, "127.0.0.1", tonumber(port))
-- 	if not ok then
-- 		vim.notify(string.format("GDScript LSP: Failed to connect to 127.0.0.1:%s\n%s", port, cmd), vim.log.levels.ERROR)
-- 		return nil
-- 	end
-- 	return cmd
-- end
--
-- local cmd = connect_gdscript()
--
return {
	-- cmd = cmd,
	on_attach = function(client, bufnr)
		-- Check if client failed to initialize
		if client.is_stopped() then
			vim.notify(string.format("GDScript LSP: Client failed to start. Is Godot running on port %s?", port), vim.log.levels.ERROR)
			return
		end

		vim.notify(string.format("GDScript LSP: Connected successfully on port %s", port), vim.log.levels.INFO)

		-- Add your other on_attach logic here (keymaps, etc.)
	end,
	on_exit = function(code, signal, client_id)
		if code ~= 0 then vim.notify(string.format("GDScript LSP: Exited unexpectedly (code: %s, signal: %s)", code, signal), vim.log.levels.WARN) end
	end,
}
