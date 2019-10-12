" VIM Configuration file
" Author    : Ved Patel
" Date      : 4 October 2018


" Disable vi compatibility
set nocompatible
filetype plugin on

" Setup Vundle
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()

Plugin 'VundleVim/Vundle.vim'
Plugin 'tpope/vim-surround'
Plugin 'junegunn/fzf'
Plugin 'tpope/vim-fugitive'
Plugin 'mattn/emmet-vim'
Plugin 'scrooloose/nerdtree'

call vundle#end()

" Set UTF-8 encoding
set enc=utf-8
set fenc=utf-8
set termencoding=utf-8



" Turn on syntax highlighting
syntax on


" Set cscope, ctags and doxygen toolkit
source ~/.vim/scripts/cscope_maps.vim
set tags=./tags


" Set indentation and UI configs
set autoindent
set smartindent
set background=light
set tabstop=4
set softtabstop=4
set shiftwidth=4
set expandtab
set showcmd
set wildmenu
set backspace=indent,eol,start
set ttimeoutlen=0

filetype on
filetype plugin on
filetype indent on


" Searching
set incsearch
set ignorecase
set hlsearch

nnoremap <leader>nhs :nohlsearch<CR>


" Folding
set foldenable
set foldlevelstart=2
set foldnestmax=2
set foldmethod=indent

nmap <leader><space> za
nmap <leader>fe :set foldenable
nmap <leader>fd :set nofoldenable


" Autocmd
augroup project
    autocmd!
    autocmd BufRead,BufNewFile *.h,*.c set filetype=c | set cindent | set foldmethod=syntax
    autocmd BufRead,BufNewFile *.go set filetype=go | set foldmethod=syntax
augroup END

" Save key bindings
nmap <F2> :w<CR>
imap <F2> <ESC>:w<CR>i
nmap <F3> :mksession!<CR>
imap <F3> <ESC>:mksession!<CR>i

" Line number key bindings
nmap <leader>sn :set number<CR>
nmap <leader>snn :set nonumber<CR>

" Buffer and tab movement key bindings
nnoremap <leader>q :bp<CR>
nnoremap <leader>w :bn<CR>
nnoremap <leader>n :tabn<CR>
nnoremap <leader>p :tabp<CR>
nnoremap <leader>1 1gt
nnoremap <leader>2 2gt
nnoremap <leader>3 3gt
nnoremap <leader>4 4gt
nnoremap <leader>5 5gt
nnoremap <leader>6 6gt
nnoremap <leader>7 7gt
nnoremap <leader>8 8gt
nnoremap <leader>9 9gt

" Mouse strategy key binding
nmap <leader>mc :set mouse=c<CR>
nmap <leader>ma :set mouse=a<CR>

" Remove Trailing spaces key binding
nmap <leader>pw :%s/\s\+$//e<CR>

" Replace word
nmap dar dawi


" Set C indent
nmap <leader>ci :set cindent<CR>
imap <leader>ci <ESC>:set cindent<CR>i


" Set FZF binding
nmap <C-f> :FZF<CR>
imap <C-f> :FZF<CR>

" Set Emmet Binding
nmap <C-p> <C-y>,
imap <C-p> <C-y>,

" Set NerdTree Bindings
let g:NERDTreeQuitOnOpen=0
let NERDTreeShowHidden=1
nmap <leader>k :NERDTreeToggle<CR>
nmap <leader>nt :NERDTree<CR>
nmap <leader>ntc :NERDTreeClose<CR>
nmap <leader>ntr :NERDTreeRefreshRoot<CR>

hi MatchParen cterm=none ctermbg=cyan ctermfg=white
hi Visual cterm=none ctermbg=250

hi ExtraWhitespace ctermbg=red guibg=red
match ExtraWhitespace /\s\+$/
