local keymaps = require("mappings")

return {
  {
    "ellisonleao/gruvbox.nvim",
    lazy = false,
    priority = 1000,
    config = function()
        require("gruvbox").setup({
            transparent_mode = true,
        })
        vim.o.background = "dark"
        vim.cmd([[colorscheme gruvbox]])
    end,
  },

  {
      "folke/noice.nvim",
      event = "VeryLazy",
      opts = {
          cmdline = { view = "cmdline", },
          messages = { view_search = false },
          lsp = {
              -- progress = { enabled = false, },
              hover = { enabled = false },
              -- signature = { enabled = false },
              override = {
                  ["vim.lsp.util.convert_input_to_markdown_lines"] = false,
                  ["vim.lsp.util.stylize_markdown"] = false,
                  ["cmp.entry.get_documentation"] = false,
              },
          },
          views = {
              mini = {
                  border = { style = "rounded" },
                  position = { row = -1 - vim.o.cmdheight }, -- better default
              },
          },
          routes = {
              { filter = { event = "msg_show", find = "%d+L,%s%d+B" }, opts = { skip = true } }, -- skip save notifications
              { filter = { event = "msg_show", find = "^%d+ more lines$" }, opts = { skip = true } }, -- skip paste notifications
              { filter = { event = "msg_show", find = "^%d+ fewer lines$" }, opts = { skip = true } }, -- skip delete notifications
              { filter = { event = "msg_show", find = "^%d+ lines yanked$" }, opts = { skip = true } }, -- skip yank notifications
          },
          presets = {
              bottom_search = true, -- use a classic bottom cmdline for search
              command_palette = true, -- position the cmdline and popupmenu together
              long_message_to_split = true, -- long messages will be sent to a split
              inc_rename = false, -- enables an input dialog for inc-rename.nvim
              lsp_doc_border = false, -- add a border to hover docs and signature help
          },
      },
      dependencies = {
          "MunifTanjim/nui.nvim",
      },
  },

  {
      "nvim-neo-tree/neo-tree.nvim",
      branch = "v3.x",
      dependencies = {
          "nvim-lua/plenary.nvim",
          "nvim-tree/nvim-web-devicons",
          "MunifTanjim/nui.nvim",
      },
      opts = {
          close_if_last_window = true,
          default_component_configs = {
              name = {
                  trailing_slash = false,
                  use_git_status_colors = true,
                  highlight = "NeoTreeFileName",
              },
              git_status = {
                  symbols = {
                      -- Change type
                      added     = "✚",
                      modified  = "",
                      deleted   = "✖",
                      renamed   = "󰁕",
                      -- Status type
                      untracked = "",
                      ignored   = "",
                      unstaged  = "󰄱",
                      staged    = "",
                      conflict  = "",
                  }
              }
          }
      }
  },

  {
    "nvim-lualine/lualine.nvim",
    dependencies = { "nvim-tree/nvim-web-devicons" },
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

  {
      "folke/trouble.nvim",
      config = true,
      cmd = "Trouble",
      keys = keymaps.trouble({
          lazy = true,
      }),
  },

  {
      "stevearc/dressing.nvim",
      opts = {
          input = {
              override = function(conf)
                  conf.col = -1
                  conf.row = 0
                  return conf
              end,
          },
          select = {
              backend = { "telescope", "nui", "builtin" },
          },
      },
  },

  {
      "folke/which-key.nvim",
      event = "VeryLazy",
      opts = {},
  },

  {
      "lewis6991/gitsigns.nvim",
      opts = {
          numhl = true,
          current_line_blame = true,
      },
      init = keymaps.gitsigns
  },

  {
      "Pocco81/true-zen.nvim",
      event = "VeryLazy",
      init = keymaps.zen
  },

  {
      "stevearc/aerial.nvim",
      opts = {
          attach_mode = "global",
          backends = { "lsp", "treesitter", "markdown", "man" },
          layout = { min_width = 28 },
          show_guides = true,
          on_attach = function(bufnr)
              vim.keymap.set("n", "{", "<cmd>AerialPrev<CR>", { buffer = bufnr })
              vim.keymap.set("n", "}", "<cmd>AerialNext<CR>", { buffer = bufnr })
          end,
      },
      keys = {
          { "<leader>t", "<cmd>AerialToggle<CR>", desc = "(Aerial) Toogle" }
      },
      dependencies = {
          "nvim-treesitter/nvim-treesitter",
          "nvim-tree/nvim-web-devicons"
      },
  }
}
