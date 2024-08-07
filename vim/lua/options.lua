-- options.lua

local opt = vim.opt
local global = vim.g
local fn = vim.fn

vim.cmd('source ~/.vim/cscope_maps.vim')

-- General
global.pymode_python = 'python3'
global.python3_host_prog = '/usr/bin/python3'

opt.tags = './tags'
opt.encoding = 'utf-8'
opt.mouse = 'c'

opt.compatible = false
opt.autowrite = true
opt.autoread = true
opt.backup = false
opt.writebackup = false
opt.swapfile = false
opt.history = 100
opt.updatetime = 300
opt.ttimeoutlen = 0
opt.complete = opt.complete - 'i'
opt.sessionoptions = opt.sessionoptions - 'options'

-- Undo
opt.undofile = true
opt.undodir = os.getenv('HOME') .. '/.vim/.vim_undoes'

-- Bells
opt.visualbell = true
opt.errorbells = false

local defaultTabSz = 4

-- Indentation & Formating
opt.expandtab = true
opt.shiftround = true
opt.autoindent = true
opt.shiftwidth = defaultTabSz
opt.tabstop = defaultTabSz
opt.softtabstop = defaultTabSz
opt.smarttab = true
opt.backspace = {'indent','eol','start'}
opt.wrap = true
opt.textwidth = 80
opt.linebreak = true
opt.lazyredraw = true
opt.showcmd = true
opt.colorcolumn = '+0,+20'

global.indentLine_conceallevel = 0

-- Searching
opt.ignorecase = true
opt.smartcase = true
opt.incsearch = true
opt.hlsearch = true
opt.magic = true

if fn.executable('ag') == 1 then
    global.ackprg = 'ag --vimgrep'
end

-- Interface
opt.ffs = {'unix', 'dos', 'mac'}
opt.scrolloff = 5
opt.foldmethod = 'indent'
opt.foldopen = opt.foldopen + 'jump'

opt.wildmenu = true
opt.shortmess = 'at'
opt.stal = 2

opt.showmatch = true
opt.mat = 2
opt.number = true
opt.ttyfast = true
opt.ruler = true
opt.hidden = true

vim.cmd('syntax on')
opt.laststatus = 2
opt.showmode = false
opt.background = 'dark'
opt.splitbelow = true
opt.splitright = true

opt.list = true
vim.cmd([[
set list
set listchars=tab:›\ ,trail:•,extends:❯,precedes:❮,nbsp:_
]])

opt.wildignore = {
    '*.o', '*.obj', '*.dylib', '*.bin', '*.dll', '*.exe',
    '*/.git/*', '*/.svn/*', '*/__pycache__/*',
    '*.jpg', '*.png' , '*.jpeg', '*.bmp', '*.gif', '*.tiff', '*.svg', '*.ico',
    '*.pyc', '*.pkl', '*.DS_Store',
    '*.aux', '*.bbl', '*.blg', '*.brf,*.fls', '*.fdb_latexmk', '*.synctex.gz', '*.xdv',
}
opt.wildignorecase = true
