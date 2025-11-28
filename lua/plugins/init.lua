return {
	"nvim-lua/plenary.nvim",
	"christoomey/vim-tmux-navigator",
	-- {
	-- "christoomey/vim-tmux-navigator",
	-- cmd = {
	-- "TmuxNavigateLeft",
	-- "TmuxNavigateDown",
	-- "TmuxNavigateUp",
	-- "TmuxNavigateRight",
	-- "TmuxNavigatePrevious",
	-- "TmuxNavigatorProcessList",
	-- },
	-- init = function() vim.g.tmux_navigator_no_mappings = 1 end,
	-- keys = {
	-- { mode = { "n", "t" }, "<c-h>", "<cmd>TmuxNavigateLeft<cr>" },
	-- { mode = { "n", "t" }, "<c-j>", "<cmd>TmuxNavigateDown<cr>" },
	-- { mode = { "n", "t" }, "<c-k>", "<cmd>TmuxNavigateUp<cr>" },
	-- { mode = { "n", "t" }, "<c-l>", "<cmd>TmuxNavigateRight<cr>" },
	-- { mode = { "n", "t" }, "<c-\\>", "<cmd>TmuxNavigatePrevious<cr>" },
	-- },
	-- },
	{ "mrjones2014/smart-splits.nvim" },
	{
		"catgoose/nvim-colorizer.lua",
		config = function() require("colorizer").setup() end,
	},
	"rhysd/conflict-marker.vim",
	{ "habamax/vim-godot", event = "VimEnter" },
	{
		"sontungexpt/url-open",
		event = "VeryLazy",
		cmd = "URLOpenUnderCursor",
		config = function()
			local status_ok, url_open = pcall(require, "url-open")
			if not status_ok then return end
			url_open.setup({})
		end,
	},
	{
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
	},
}
