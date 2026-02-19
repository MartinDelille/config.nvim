vim.g.nvim_ghost_autostart = 0

return {
	"subnut/nvim-ghost.nvim",
	config = function()
		local group = vim.api.nvim_create_augroup("nvim_ghost_user_autocommands", { clear = false })
		vim.api.nvim_create_autocmd("User", {
			group = group,
			pattern = "cssbattle.dev",
			command = "setfiletype html",
		})
	end,
}
