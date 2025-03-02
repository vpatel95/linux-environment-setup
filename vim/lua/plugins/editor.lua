return {
  {
    "nvim-neo-tree/neo-tree.nvim",
    opts = {
      default_component_configs = {
        name = {
          use_git_status_colors = true,
        },
        git_status = {
          symbols = {
            -- Change type
            added = "✚",
            modified = "",
            deleted = "✖",
            renamed = "󰁕",
            -- Status type
            untracked = "",
            ignored = "",
            conflict = "",
          },
        },
      },
    },
  },

  {
    "lewis6991/gitsigns.nvim",
    opts = {
      numhl = true,
      current_line_blame = true,
    },
  },

  {
    "sindrets/diffview.nvim",
    lazy = true,
    cmd = {
      "DiffviewOpen",
      "DiffviewToggleFiles",
      "DiffviewLog",
      "DiffviewFileHistory",
    },
  },

  {
    "dhananjaylatkar/cscope_maps.nvim",
    event = "VeryLazy",
    opts = {
      prefix = "<leader>cc",
      skip_input_prompt = true,
      cscope = {
        picker = "snacks",
        db_build_cmd = { args = { "-bqv" } },
        skip_picker_for_single_result = true,
      },
    },
  },
}
