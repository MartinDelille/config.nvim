vim.pack.add({ {
  src = "https://github.com/nvim-treesitter/nvim-treesitter",
  build = ":TSUpdate",
  branch = "main",
} })

require("nvim-treesitter").install(
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
  "tsx"
)
