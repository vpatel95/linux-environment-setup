local keymaps = require("mappings")

return {
  {
    "nvim-lualine/lualine.nvim",
    dependencies = { "nvim-tree/nvim-web-devicons" },
    init = keymaps.lualine(),
    opts = {
      options = { theme = "gruvbox" },
      sections = {
        lualine_c = {
          {"filename", path = 1 }
        },
      },
      tabline = {
        lualine_a = {
          {"buffers", mode = 2 }
        },
        lualine_z = {"tabs"}
      },
    }
  },
}
