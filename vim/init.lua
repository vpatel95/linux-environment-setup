-- init.lua

require('plugins')
require('plugins-config')
require('options')
require('auto-commands')
require('mappings')

vim.cmd('source ~/.vim/cscope_maps.vim')
vim.cmd('source ~/.config/nvim/old.vim')
