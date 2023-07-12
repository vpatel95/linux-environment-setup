-- Autocommands
local utils = require('utils')
local cmd = vim.cmd

vim.cmd([[
    filetype on
    filetype plugin on
    filetype indent on
]])

utils.define_augroups({
    _coc = {
        { 'User', 'CocJumpPlaceholder', 'call', 'CocActionAsync(\'showSignatureHelp\')' }
    },
    _file_settings = {
        {'BufRead,BufNewFile', '*.java', 'set filetype=java', '|', 'set foldmethod=syntax' },
        {'BufRead,BufNewFile', '*.c,*.h', 'set filetype=c', '|', 'set cindent', '|', 'set foldmethod=syntax', '|', 'set textwidth=100', '|', 'set cc=100' },
        {'BufRead,BufNewFile', '*.cc,*.hh,*.cpp,*.hpp', 'set filetype=cpp', '|', 'set cindent', '|', 'set foldmethod=syntax', '|', 'set textwidth=100', '|', 'set cc=100' },
        {'BufRead,BufNewFile', '*.go', 'set filetype=go', '|', 'set foldmethod=syntax' },
        {'BufRead,BufNewFile', '*.py', 'set filetype=python', '|', 'set foldmethod=indent', '|', 'set textwidth=80', '|', 'set cc=80' },
        {'BufRead,BufNewFile', '*.aliases', 'set filetype=sh', '|', 'set foldmethod=indent' }
    }
})
