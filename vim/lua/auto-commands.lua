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
        {'BufRead,BufNewFile', '*.c,*.h', 'set filetype=c', '|', 'set cindent', '|', 'set foldmethod=syntax' },
        {'BufRead,BufNewFile', '*.cc,*.hh,*.cpp,*.hpp', 'set filetype=cpp', '|', 'set foldmethod=syntax' },
        {'BufRead,BufNewFile', '*.go', 'set filetype=go', '|', 'set foldmethod=syntax' },
        {'BufRead,BufNewFile', '*.py', 'set filetype=py', '|', 'set foldmethod=indent' },
        {'BufRead,BufNewFile', '*.aliases', 'set filetype=sh', '|', 'set foldmethod=indent' }
    }
})
