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
      adapter = "claude_code",
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
      opts = {
        auto_generate_title = false,
        picker = "snacks",
      },
    },
  },
  interactions = {
    chat = {
      keymaps = {
        next_chat = false,
        previous_chat = false,
      },
      opts = {
        completion_provider = "default",
      },
    },
  },
})

vim.keymap.set("n", "<leader>cc", function() chat.toggle() end, { desc = "Code Companion" })
