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

vim.cmd([[
let g:neoformat_cpp_clangformat = {
    \ 'exe': 'clang-format',
    \ 'args': ['--style="{IndentWidth: 4, ColumnLimit: 80}"']
\}
let g:neoformat_enabled_cpp = ['clangformat']
let g:neoformat_enabled_c = ['clangformat']
]])

vim.cmd('colorscheme gruvbox')

require("nvim-tree").setup({
    sort = {
        sorter = "case_sensitive"
    }
})

global.airline_extensions = {'tabline', 'branch', 'hunks'}
global.airline_powerline_fonts = 1
global['airline#extensions#tabline#enabled'] = 1
global['airline#extensions#tabline#buffer_idx_mode'] = 1
global['airline#extensions#tabline#show_tabs'] = 1
global['airline#extensions#tabline#tab_nr_type'] = 1
global['airline#extensions#hunks#enabled'] = 1
global['airline#extensions#branch#enabled'] = 1

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

global.coc_disable_startup_warning = 1

if fn.has("nvim-0.5.0") or fn.has("patch-8.1.1564") then
    opt.signcolumn = 'number'
else
    opt.signcolumn = 'yes'
end

require('dressing').setup({
    select = {
        backend = { "telescope", "fzf", "builtin" }
    }
})

require('cscope_maps').setup({
    skip_input_prompt = true,
    cscope = {
        picker = 'telescope',
        db_build_cmd_args = { "-bqv" },
    }
})
