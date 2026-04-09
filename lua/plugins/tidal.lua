vim.g.maplocalleader = ","

return {
	"tidalcycles/vim-tidal",
	ft = "tidal",

	config = function()
		vim.g.tidal_sc_enable = 1 -- Set to 1 to enable
		-- Path to sclang executable
		vim.g.tidal_sclang = "/Applications/SuperCollider.app/Contents/MacOS/sclang"

		-- Path to boot file (expanded)
		local sc_boot = vim.fn.expand("~/Library/Application Support/SuperCollider/startup.scd")
		vim.g.tidal_sc_boot = sc_boot

		-- Explicitly set the full boot command
		vim.g.tidal_sc_boot_cmd = vim.g.tidal_sclang .. " " .. vim.fn.shellescape(sc_boot)

		-- Use custom Tidal boot file with GlslViewer support
		-- Uncomment to enable shader control:
		vim.g.tidal_boot = vim.fn.expand("~/.config/tidal/TidalGlsl.ghci")

		-- Enable completions for Dirt-Samples
		vim.api.nvim_create_autocmd("FileType", {
			pattern = "tidal",
			callback = function()
				-- Enable keyword completion from dictionary
				vim.opt_local.complete:append("k")
				-- Set completion options
				vim.opt_local.completeopt = "menu,menuone,noselect"
			end,
		})
	end,

	keys = {
		-- These are the default keybindings that will be available
		-- Add them here for documentation or to override them
		{ "<C-e>", desc = "Send paragraph/selection to Tidal (Normal/Visual/Insert)" },
		{ "<localleader>ss", desc = "Send paragraph to Tidal", mode = "n" },
		{ "<localleader>s", desc = "Send line to Tidal", mode = "n" },
		{ "<localleader>s", desc = "Send selection to Tidal", mode = "x" },
		{ "<localleader>h", desc = "Hush (silence all streams)", mode = "n" },
		{ "<C-h>", desc = "Hush (silence all streams)", mode = "n" },
		-- <localleader>1-9 silences stream d1-d9
		-- <localleader>s1-s9 plays stream d1-d9
	},
}
