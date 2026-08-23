vim.pack.add({
  "https://github.com/olimorris/codecompanion.nvim",
  "https://github.com/ravitemer/codecompanion-history.nvim",
})

local chat = require("codecompanion")

chat.setup({
  action_palette = {
    provider = "snacks",
  },
  strategies = {
    chat = {
      adapter = {
        name = "copilot_acp",
      },
      keymaps = {
        next_chat = false,
        previous_chat = false,
      },
    },
  },
  opts = {
    title_generation_opts = {
      enabled = false,
    },
  },
  extensions = {
    history = {
      enabled = true,
      opts = {},
    },
  },
  interactions = {
    chat = {
      opts = {
        completion_provider = "default",
      },
    },
  },
})

vim.keymap.set("n", "<leader>cc", function() chat.toggle() end, { desc = "Code Companion" })
