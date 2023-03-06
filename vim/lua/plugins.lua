-- plugins.lua

-- Setup plugin manager
local ensure_packer = function()
    local fn = vim.fn
    local install_path = fn.stdpath('data') .. '/site/pack/packer/start/packer.nvim'
    if fn.empty(fn.glob(install_path)) > 0 then
        fn.system({'git', 'clone', '--depth', '1', 'https://github.com/wbthomason/packer.nvim', install_path})
        vim.cmd [[packadd packer.nvim]]
        return true
    end
    return false
end

local packer_bootstrap = ensure_packer()

local packer = require('packer')
local util = require('packer.util')

return packer.startup(function(use)
    use { 'wbthomason/packer.nvim' }

    use { 'neoclide/coc.nvim', branch = 'release' }
    use { 'tpope/vim-surround' }
    use { 'tpope/vim-commentary' }
    use { 'tpope/vim-fugitive' }
    use { 'airblade/vim-gitgutter' }
    use { 'godlygeek/tabular' }
    use {
        'nvim-tree/nvim-tree.lua',
        requires = { 'nvim-tree/nvim-web-devicons' } -- optional, updated every week. (see issue #1193)
    }
    use { 'majutsushi/tagbar' }
    use { 'andymass/vim-matchup' }
    use { 'mileszs/ack.vim' }
    use { 'sjl/gundo.vim' }
    use { 'junegunn/fzf.vim' }
    use { 'junegunn/fzf' }
    use { 'wellle/targets.vim' }
    use { 'vim-airline/vim-airline' }
    use { 'vim-airline/vim-airline-themes' }
    use { 'morhetz/gruvbox' }
    use { 'ryanoasis/vim-devicons' }
    use { 'nvim-treesitter/nvim-treesitter', run = ':TSUpdate' }

    use { 'neovim/nvim-lspconfig' }

    if packer_bootstrap then
        packer.sync()
    end
end)
