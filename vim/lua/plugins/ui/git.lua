local keymaps = require("mappings")

return {
  {
      "lewis6991/gitsigns.nvim",
      opts = {
          numhl = true,
          current_line_blame = true,
      },
      init = keymaps.gitsigns
  },

  {
    "sindrets/diffview.nvim",
    event = "VeryLazy",
    cmd = { "DiffviewOpen", "DiffviewToggleFiles", "DiffviewLog", "DiffviewFileHistory" },
  },
}
