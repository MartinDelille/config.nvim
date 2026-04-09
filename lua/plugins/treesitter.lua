vim.pack.add({ {
	src = "https://github.com/nvim-treesitter/nvim-treesitter",
	build = ":TSUpdate",
	branch = "main",
}, "https://github.com/windwp/nvim-ts-autotag" })

require("nvim-treesitter").setup({ -- enable syntax highlighting
	highlight = {
		enable = true,
	},
	-- enable indentation
	indent = { enable = true },
	-- enable autotagging (w/ nvim-ts-autotag plugin)
	autotag = {
		enable = true,
	},
	-- ensure these language parsers are installed
	ensure_installed = {
		"json",
		"javascript",
		"yaml",
		"html",
		"css",
		"markdown",
		"markdown_inline",
		"python",
		"bash",
		"lua",
		"vim",
		"gitignore",
		"query",
		"vimdoc",
		"c",
		"cpp",
		"gdscript",
		"godot_resource",
		"gdshader",
		"glsl",
		"angular",
		"typescript",
		"tsx",
	},
	incremental_selection = {
		enable = true,
		keymaps = {
			init_selection = "<C-space>",
			node_incremental = "<C-space>",
			scope_incremental = false,
			node_decremental = "<bs>",
		},
	},
})
