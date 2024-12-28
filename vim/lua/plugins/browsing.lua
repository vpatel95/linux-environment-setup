local keymaps = require("mappings")

return {
    {
        "nvim-telescope/telescope.nvim", tag = "0.1.8",
        dependencies = { "nvim-lua/plenary.nvim" },
        opts = function()
            local tsorter = require("telescope.sorters")
            return {
                defaults = {
                    vimgrep_arguments = {
                        "rg",
                        "-L",
                        "--color=never",
                        "--no-heading",
                        "--with-filename",
                        "--line-number",
                        "--column",
                        "--smart-case",
                    },
                    path_display = { "shorten" },
                },
                initial_mode = "insert",
                selection_strategy = "reset",
                sorting_strategy = "ascending",
                layout_strategy = "horizontal",
                layout_config = {
                    horizontal = {
                        prompt_position = "top",
                        preview_width = 0.55,
                        results_width = 0.8,
                    },
                    vertical = {
                        mirror = false,
                    },
                    width = 0.87,
                    height = 0.80,
                    preview_cutoff = 120,
                },
                generic_sorter = tsorter.get_generic_fuzzy_sorter,
                -- file_previewer = require("telescope.previewers").vim_buffer_cat.new,
                -- grep_previewer = require("telescope.previewers").vim_buffer_vimgrep.new,
                -- qflist_previewer = require("telescope.previewers").vim_buffer_qflist.new,
            }
        end,
        init = keymaps.telescope,
    },

    {
        "dhananjaylatkar/cscope_maps.nvim",
        event = "VeryLazy",
        opts = {
            skip_input_prompt = true,
            cscope = {
                picker = "telescope",
                db_build_cmd_args = {"-bqv"}
            }
        }
    }
}
