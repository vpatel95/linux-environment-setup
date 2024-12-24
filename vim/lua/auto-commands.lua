-- Autocommands
local utils = require('utils')
local cmd = vim.cmd

vim.cmd([[
    filetype on
    filetype plugin on
    filetype indent on
]])

utils.define_augroups({
    _file_settings = {
        {'BufRead,BufNewFile', '*.java', 'set filetype=java', '|', 'set foldmethod=syntax' },
        {'BufRead,BufNewFile', '*.c,*.h', 'set filetype=c', '|', 'set cindent', '|', 'set foldmethod=syntax' },
        {'BufRead,BufNewFile', '*.cc,*.hh,*.cpp,*.hpp', 'set filetype=cpp', '|', 'set cindent', '|', 'set foldmethod=syntax' },
        {'BufRead,BufNewFile', '*.go', 'set filetype=go', '|', 'set foldmethod=syntax' },
        {'BufRead,BufNewFile', '*.py', 'set filetype=python', '|', 'set foldmethod=indent' },
        {'BufRead,BufNewFile', '*.aliases', 'set filetype=sh', '|', 'set foldmethod=indent' },
        {'BufRead,BufNewFile', '*.sandesh', 'set filetype=proto', '|', 'set foldmethod=indent' },
        {'BufRead,BufNewFile', '*.npl', 'set filetype=npl', '|', 'set cindent', '|', 'set foldmethod=syntax' }
    },
    _lsp = {
        {'CursorHold,CursorHoldI', '*', 'lua vim.diagnostic.open_float(nil, {focus=false})'}
    }
})
