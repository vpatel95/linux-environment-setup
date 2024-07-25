-- options.lua

local defaultTabSz = 4

local global_options = {
    pymode_python           = 'python3',
    python3_host_prog       = '/usr/bin/python3',
    indentLine_conceallevel = 0
}

local options = {
    -- General
    tags            = './tags',
    encoding        = 'utf-8',
    mouse           = 'c',
    compatible      = false,
    autowrite       = true,
    autoread        = true,
    backup          = false,
    writebackup     = false,
    swapfile        = false,
    history         = 100,
    updatetime      = 300,
    ttimeoutlen     = 0,
    complete        = vim.opt.complete - 'i',
    sessionoptions  = vim.opt.sessionoptions - 'options',
    -- Undo
    undofile        = true,
    undodir         = os.getenv('HOME') .. '/.vim/.vim_undoes',
    -- Bells
    visualbell      = true,
    errorbells      = false,
    -- Indentation & Formating
    expandtab       = true,
    shiftround      = true,
    autoindent      = true,
    shiftwidth      = defaultTabSz,
    tabstop         = defaultTabSz,
    softtabstop     = defaultTabSz,
    smarttab        = true,
    backspace       = {'indent','eol','start'},
    wrap            = true,
    textwidth       = 80,
    linebreak       = true,
    lazyredraw      = true,
    showcmd         = true,
    colorcolumn     = '+0,+20',
    -- Searching
    ignorecase      = true,
    smartcase       = true,
    incsearch       = true,
    hlsearch        = true,
    magic           = true,
    -- Interface
    ffs             = {'unix', 'dos', 'mac'},
    scrolloff       = 5,
    foldmethod      = 'indent',
    foldopen        = vim.opt.foldopen + 'jump',
    wildmenu        = true,
    shortmess       = 'at',
    stal            = 2,
    showmatch       = true,
    mat             = 2,
    number          = true,
    ttyfast         = true,
    ruler           = true,
    hidden          = true,
    laststatus      = 2,
    showmode        = false,
    background      = 'dark',
    splitbelow      = true,
    splitright      = true,
    list            = true,
    wildignore      = {'*.o', '*.obj', '*.dylib', '*.bin', '*.dll', '*.exe',
                       '*/.git/*', '*/.svn/*', '*/__pycache__/*',
                       '*.jpg', '*.png' , '*.jpeg', '*.bmp', '*.gif', '*.tiff', '*.svg', '*.ico',
                       '*.pyc', '*.pkl', '*.DS_Store',
                       '*.aux', '*.bbl', '*.blg', '*.brf,*.fls', '*.fdb_latexmk', '*.synctex.gz', '*.xdv', },
    wildignorecase  = true
}

for k, v in pairs(options) do
    vim.opt[k] = v
end

for k, v in pairs(global_options) do
    vim.g[k] = v
end

if vim.fn.executable('ag') == 1 then
    vim.g.ackprg = 'ag --vimgrep'
end

vim.cmd('source ~/.vim/cscope_maps.vim')
vim.cmd('syntax on')
vim.cmd([[
set list
set listchars=tab:›\ ,trail:•,extends:❯,precedes:❮,nbsp:_
]])

