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
    use { 'tpope/vim-surround' }
    use { 'tpope/vim-commentary' }
    use { 'tpope/vim-fugitive' }
    use { 'morhetz/gruvbox' }
    use { 'vim-airline/vim-airline-themes' }
    use { 'wellle/targets.vim' }
    use { 'junegunn/fzf' }
    use { 'andymass/vim-matchup' }
    use { 'mileszs/ack.vim' }
    use { 'fatih/vim-go' }
    use { 'sbdchd/neoformat' }
    use { 'neoclide/coc.nvim', branch = 'release' }
    use { 'airblade/vim-gitgutter', branch = 'main' }
    use { 'nvim-tree/nvim-tree.lua',
        requires = { 'nvim-tree/nvim-web-devicons' }
    }
    use { 'majutsushi/tagbar' }
    use { 'sjl/gundo.vim' }
    use { 'ibhagwan/fzf-lua',
        requires = { 'nvim-tree/nvim-web-devicons' },
    }
    use { 'vim-airline/vim-airline' }
    use { 'nvim-treesitter/nvim-treesitter', run = ':TSUpdate' }
    use { 'stevearc/dressing.nvim' }
    use { 'nvim-telescope/telescope.nvim',
        tag = '0.1.5', requires = {'nvim-lua/plenary.nvim'}
    }
    use { 'dhananjaylatkar/cscope_maps.nvim' }

    if packer_bootstrap then
        packer.sync()
    end
end)
