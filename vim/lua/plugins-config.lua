-- Plugins Configuration

local fn = vim.fn
local global = vim.g
local opt = vim.opt

if fn.has('python3') then
    global.gundo_prefer_python3 = 1
end

global.gundo_width = 48
global.gundo_preview_height = 13
global.gundo_preview_bottom = 1
global.gundo_right = 1
global.gundo_help = 0

global.tagbar_width = 48
global.tagbar_autopreview = 1
global.tagbar_show_linenumbers = 1
global.tagbar_wrap = 0
global.tagbar_map_showproto = ''
global.tagbar_autofocus = 1
global.tagbar_compact = 1
global.tagbar_autoclose = 1

global.loaded_newtr = 1
global.loaded_netrwPlugin = 1

global.go_def_mapping_enabled = 0

vim.cmd('colorscheme gruvbox')

require('lualine').setup({
    sections = {
        lualine_c = {
            {'filename',
                path = 1
            }
        }
    },
    tabline = {
        lualine_a = {
            {'buffers',
                mode = 2
            }
        },
        lualine_z = {'tabs'}
    },
})

require("nvim-tree").setup({
    sort = {
        sorter = "case_sensitive"
    }
})

require('gitsigns').setup({
    numhl = true,
    current_line_blame = true,
})

require 'nvim-treesitter.configs'.setup {
    ensure_installed = {
        'c', 'cpp', 'bash', 'go', 'json',
        'lua', 'python', 'vim', 'yaml'
    },

    sync_install = true,
    auto_install = true,
    ignore_install = { "javascript" },

    highlight = {
        enable = true,

        disable = function(lang, buf)
            local max_filesize = 10 * 1024 * 1024 -- 100 KB
            local ok, stats = pcall(vim.loop.fs_stat, vim.api.nvim_buf_get_name(buf))
            if ok and stats and stats.size > max_filesize then
                return true
            end
        end,

        additional_vim_regex_highlighting = true,
    },

    matchup = {
        enable = true,
        disable = {"python"},
    },
}

require('dressing').setup({
    select = {
        backend = { "telescope", "builtin" }
    }
})

require('telescope').setup({
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
    generic_sorter = require("telescope.sorters").get_generic_fuzzy_sorter,
    path_display = { "shorten" },
    -- file_previewer = require("telescope.previewers").vim_buffer_cat.new,
    -- grep_previewer = require("telescope.previewers").vim_buffer_vimgrep.new,
    -- qflist_previewer = require("telescope.previewers").vim_buffer_qflist.new,
})

require('cscope_maps').setup({
    skip_input_prompt = true,
    cscope = {
        picker = 'telescope',
        db_build_cmd_args = { "-bqv" },
    }
})
