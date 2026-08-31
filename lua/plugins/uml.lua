vim.filetype.add({
  extension = { uml = "plantuml" },
})

vim.pack.add({
  "https://github.com/aklt/plantuml-syntax",
  {
    src = "https://gitlab.com/itaranto/preview.nvim",
    version = vim.version.range("1.x"),
  },
})

local opt = {
  previewers_by_ft = {
    plantuml = {
      name = "plantuml_text",
      renderer = { type = "buffer", opts = { split_cmd = "vsplit" } },
    },
  },
  render_on_write = true,
}
require("preview").setup(opt)
