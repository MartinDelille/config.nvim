vim.g.maplocalleader = ","

vim.pack.add({ "https://github.com/tidalcycles/vim-tidal" })

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
-- vim.g.tidal_boot = vim.fn.expand("~/.config/tidal/TidalGlsl.ghci")

-- Enable completions for Dirt-Samples
vim.api.nvim_create_autocmd("FileType", {
  pattern = "tidal",
  callback = function()
    -- Enable keyword completion from dictionary
    vim.opt_local.complete:append("k")
    -- Set completion options
    vim.opt_local.completeopt = "menu,menuone,noselect"
    vim.keymap.del({ "n", "v", "t" }, "<c-h>", { buffer = true })
    vim.keymap.set("n", "<localleader>h", "<cmd>TidalHush<cr>", { buffer = true, desc = "Hush (silence all streams)" })
  end,
})
