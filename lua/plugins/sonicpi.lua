return {
	"magicmonty/sonicpi.nvim",
	dependencies = {
		"hrsh7th/nvim-cmp",
		"kyazdani42/nvim-web-devicons",
	},
	opts = {
		server_dir = "/Applications/Sonic Pi.app/Contents/Resources/app/server",
		-- daemon_path = "/Applications/Sonic Pi.app/Contents/Resources/app/server/ruby/bin/daemon.rb",
	},
	ft = { "sonicpi" }, -- or "ruby" if Sonic Pi files use .rb
	keys = {
		{ "<leader>pp", "<cmd>SonicPiStart<cr>", desc = "Start Sonic Pi" },
		{ "<leader>pt", "<cmd>SonicPiStop<cr>", desc = "Quit Sonic Pi" },
		{ "<leader>ps", "<cmd>SonicPiSendBuffer<cr>", desc = "Run Buffer in Sonic Pi" },
		{ "<leader>pl", "<cmd>SonicPiRunLine<cr>", desc = "Run Line in Sonic Pi" },
	},
}
