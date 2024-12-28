return {
  {
      "stevearc/aerial.nvim",
      enabled = true,
      opts = {
          attach_mode = "global",
          backends = { "lsp", "treesitter", "markdown", "man" },
          layout = { min_width = 28 },
          show_guides = true,
          filter_kind = false,
          on_attach = function(bufnr)
              vim.keymap.set("n", "{", "<cmd>AerialPrev<CR>", { buffer = bufnr })
              vim.keymap.set("n", "}", "<cmd>AerialNext<CR>", { buffer = bufnr })
          end,
      },
      keys = {
          { "<leader>s", "<cmd>AerialToggle<CR>", desc = "(Aerial) Toogle" }
      },
      dependencies = {
          "nvim-treesitter/nvim-treesitter",
          "nvim-tree/nvim-web-devicons"
      },
  },

  {
      "majutsushi/tagbar",
      enabled = false,
      config = function()
          vim.g.tagbar_width = 30
          vim.g.tagbar_autopreview = 0
          vim.g.tagbar_show_linenumbers = 1
          vim.g.tagbar_wrap = 0
          vim.g.tagbar_autofocus = 1
          vim.g.tagbar_compact = 1
          vim.g.tagbar_autoclose = 1
          vim.g.tagbar_silent = 1
      end
  },
}
