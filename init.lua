require("core")

vim.diagnostic.config({
  virtual_text = true,
})

vim.lsp.enable({ "lua_ls" , "gdscript"})

require("lazy_config")
require("themes")
vim.cmd("colorscheme " .. get_colorscheme("default"))
