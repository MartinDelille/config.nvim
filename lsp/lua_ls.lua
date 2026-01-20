return {
	settings = {
		Lua = {
			workspace = {
				checkThirdParty = true,
				library = {
					vim.env.VIMRUNTIME,
				},
			},
			diagnostics = {
				disable = { "missing-fields" },
			},
		},
	},
}
