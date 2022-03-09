" NeoVIM Configuration file
" Author    : Ved Patel
" Date      : 24 December 2019


" Initialization: {
    set nocompatible
    filetype off

    let g:pymode_python = 'python3'

    call plug#begin('~/.vim/.vim_plug')
" }

" Plugins: {
    " Functional: {
        Plug 'neoclide/coc.nvim', {'branch': 'release'}
        Plug 'tpope/vim-surround'     " Change (){}<>'' in a snap.
        Plug 'tpope/vim-commentary'
        Plug 'tpope/vim-fugitive'
        Plug 'godlygeek/tabular' " Easy automatic tabulations.
        Plug 'scrooloose/nerdtree' " Better than NetRw, maybe.
        Plug 'majutsushi/tagbar' " Nice to get a code topview.
        Plug 'andymass/vim-matchup' " The '%'now matches more k?
        Plug 'mileszs/ack.vim' " Forget IDE searches gtg fast!
        Plug 'sjl/gundo.vim' " Why only have linear undo tree?
        Plug 'junegunn/fzf.vim' " Fuzzy file search.
        Plug 'junegunn/fzf' " Fuzzy file search.
        Plug 'wellle/targets.vim' " Adds various text objects and targets.
        " Plug 'pappasam/coc-jedi', { 'do': 'yarn install --frozen-lockfile && yarn build', 'branch': 'main' }
    " }

    " Cosmetics: {
        Plug 'glepnir/dashboard-nvim'
        Plug 'vim-airline/vim-airline'
        Plug 'vim-airline/vim-airline-themes'
        Plug 'morhetz/gruvbox' " Color schemes
    " }

    " Syntaxes: {
        Plug 'octol/vim-cpp-enhanced-highlight' " C++ advanced highlighting
    "}
" }

" Preliminaries: {
    call plug#end() " Let vim-plug finish initializing itself now.
    filetype plugin indent on " Enable file specific features...

    source ~/.vim/scripts/cscope_maps.vim
    set tags=./tags
" }

" General: {
    set autowrite " Write automatically when :make, :next etc...
    set autoread " Reload file when it has been changed externally.
    set nobackup " No need for .bkp files when version control exist.
    set nowritebackup " If Vim crashes often then turn backups on again, look at docs for more information.
    set noswapfile " Don't create swap files, nowadays we should have enough memory to store a text file.
    set complete-=i " Completion list for all included files is a bad idea, scanning could take a while.
    set sessionoptions-=options " Don't store options (global variables etc...) when making a session.

    set undodir=~/.vim/.vim_undoes " Where do we store all this awesomeness?!?!
    set undofile " Persistent undos are completely freaking awesome!!!

    set history=100 " Defines the number of stored commands Vim can remember, doesn't really matter :).
    set updatetime=300
    set ttimeoutlen=0
    let g:indentLine_conceallevel = 0

    set visualbell noerrorbells
" }

" Formatting: {
    set expandtab " Expand tab characters to space characters.
    set shiftwidth=4 " One tab is now 4 spaces.
    set shiftround " Always round up to the nearest tab.
    set tabstop=4 " This one is also needed to achieve the desired effect.
    set softtabstop=4 " Enables easy removal of an indentation level.

    set autoindent " Automatically copy the previous indent level. Don't use smartindent!!!
    set backspace=indent,eol,start " Used for making backspace work like in most other editors
    set wrap " Wrap text. This is also quite optional, replace with textwidth=80 is you don't want this behaviour.
    set lazyredraw " Good performance boost when executing macros, redraw the screen only on certain commands.
    set showcmd
" }

" Searching: {
    set ignorecase " Search is not case sensitive, which is usually what we want.
    set smartcase " Will override some ignorecase properties, when using caps it will do a special search.
    set incsearch " Enables the user to step through each search 'hit', usually what is desired here.
    set hlsearch " Will stop highlighting current search 'hits' when another search is performed.
    set magic " Enables regular expressions. They are a bit like magic (not really though, DFA).

    " Ack and Ag are incredibly useful for searching really fast, forget slow IDE searching.
    if executable('ag') " The Silver Searcher, faster than 'ack' (mostly)
        let g:ackprg = 'ag --vimgrep' " Enables ag compat. with vim.
    endif " Will use 'ag' if exists, otherwise uses normal Ack.
" }

" Interface: {
    set ffs=unix,dos,mac " Prioritize unix as the standard file type.
    set encoding=utf-8 " Vim can now work with a whole bunch more characters (powerline too).
    set scrolloff=8 " The screen will only scroll when the cursor is 8 characters from the top/bottom.
    set foldmethod=indent " Pressing zc will close a fold at the current indent while zo will open one.
    set foldopen+=jump " Additionally, open folds when there is a direct jump to the location.

    set wildmenu " Enable the 'autocomplete' menu when in command mode (':').
    set shortmess=at " Shorten some command mode messages, will keep you from having to hit ENTER all the time.
    set stal=2 " Always show the tab lines, which makes the user interface a bit more consistent.

    set showmatch " Will highlight matching brackets.
    set mat=2 " How long the highlight will last.
    set number " Show line numbers on left side.
    set ttyfast " Will send characters over a terminal connection faster. We do have fast connections after all.
    set ruler " Always show current cursor position, which might be needed for the character column location.
    set hidden " Abandon buffer when closed, which is usually what we want to do in this case.

    syntax on " The most important feature when coding. Vim please bless us with this option right now!.
    set laststatus=2 " Always have a status line, this is required in order for Lightline to work correctly.
    set noshowmode " Disables standard -INSERT-, -NORMAL-, etc... Lightline will provide a better looking one for us.
    set t_Co=256 " This will 'force' terminals to use 256 colors, enabling Lightline and the colorscheme to look correct.
    set t_ut=

    set background=dark " Cool programmers only use dark themes. It's good for your eyes man, really nice!
    colorscheme gruvbox
    let s:current_bg = "dark"

    " set fillchars=fold:\ ,vert:\│,eob:\ ,msgsep:‾
    set splitbelow splitright

    " Windows: {
        if has('python3')
            let g:gundo_prefer_python3 = 1
        endif
        let g:gundo_width = 48
        let g:gundo_preview_height = 13
        let g:gundo_preview_bottom = 1
        let g:gundo_right = 1 " Open gundo window on right
        let g:gundo_help = 0

        let g:tagbar_width = 48
        let g:tagbar_autopreview = 1
        let g:tagbar_show_linenumbers = 1 " Absolute line number (2 - relative, -1 - global)
        let g:tagbar_wrap = 0
        let g:tagbar_map_showproto=""
        let g:tagbar_autofocus = 1
        let g:tagbar_compact = 1
        let g:tagbar_autoclose = 1

        let g:NERDTreeWinSize = 48
        let g:NERDTreeMinimalUI = 1
        let g:NERDTreeShowLineNumbers = 1
        autocmd FileType nerdtree setlocal relativenumber
    " }

    " Graphical: {
        if has("gui_running")
            set guioptions=i " Kill them toolbars!
            if has("win32")
                set shellslash " Fix for Fugitive.
                set guifont=Hack:h10,Monospace:h10
                " Below we inject a DLL that removes the annoying GTK padding when using Win32.
                map <F11> <Esc>:call libcallnr("gvimfullscreen.dll", "ToggleFullScreen", 0)<CR>
            else
                set guifont=Hack\ 10,Monospace\ 10
            endif
        else
            set mouse=c " Mouse support if needed.
        endif

        " Enable Airline
        let g:airline_extensions = ['tabline']
        let g:airline_powerline_fonts = 1
        let g:airline#extensions#tabline#enabled = 1
        let g:airline#extensions#tabline#buffer_idx_mode = 1

    " }

    " AutoCompletion: {
        let g:coc_disable_startup_warning = 1

        set shortmess+=c

        if has("nvim-0.5.0") || has("patch-8.1.1564")
            set signcolumn=number
        else
            set signcolumn=yes
        endif

        inoremap <silent><expr> <TAB>
                \ pumvisible() ? "\<C-n>" :
                \ <SID>check_back_space() ? "\<TAB>" :
                \ coc#refresh()

        function! s:check_back_space() abort
            let col = col('.') - 1
            return !col || getline('.')[col - 1] =~# '\s'
        endfunction


        inoremap <expr><UP> pumvisible() ? "\<C-p>" : "\<UP>"
        inoremap <expr><DOWN> pumvisible() ? "\<C-n>" : "\<DOWN>"
        inoremap <expr> <CR> pumvisible() ? "\<C-y>" : "\<C-g>u\<CR>"

        inoremap <silent><expr> <C-Space> coc#refresh()

        nmap <silent> [c <Plug>(coc-diagnostic-prev)
        nmap <silent> ]c <Plug>(coc-diagnostic-next)

        " nmap <silent> gd <Plug>(coc-definition)
        " nmap <silent> gy <Plug>(coc-type-definition)
        " nmap <silent> gi <Plug>(coc-implementation)
        " nmap <silent> gr <Plug>(coc-references)

        nnoremap <silent> K :call <SID>show_documentation()<CR>

        function! s:show_documentation()
            if (index(['vim','help'], &filetype) >= 0)
                execute 'h '.expand('<cword>')
            else
                call CocAction('doHover')
            endif
        endfunction

        " Add `:Format` command to format current buffer.
        command! -nargs=0 Format :call CocAction('format')

        " Add `:Fold` command to fold current buffer.
        command! -nargs=? Fold :call     CocAction('fold', <f-args>)

        " Add `:OR` command for organize imports of the current buffer.
        command! -nargs=0 OR   :call     CocActionAsync('runCommand', 'editor.action.organizeImport')

        " Add (Neo)Vim's native statusline support.
        " NOTE: Please see `:h coc-status` for integrations with external plugins that
        " provide custom statusline: lightline.vim, vim-airline.
        set statusline^=%{coc#status()}%{get(b:,'coc_current_function','')}

        " Mappings for CoCList
        " Show all diagnostics.
        nnoremap <silent><nowait> <space>a  :<C-u>CocList diagnostics<cr>
        " Manage extensions.
        nnoremap <silent><nowait> <space>e  :<C-u>CocList extensions<cr>
        " Show commands.
        nnoremap <silent><nowait> <space>c  :<C-u>CocList commands<cr>
        " Find symbol of current document.
        nnoremap <silent><nowait> <space>o  :<C-u>CocList outline<cr>
        " Search workspace symbols.
        nnoremap <silent><nowait> <space>s  :<C-u>CocList -I symbols<cr>
        " Do default action for next item.
        nnoremap <silent><nowait> <space>j  :<C-u>CocNext<CR>
        " Do default action for previous item.
        nnoremap <silent><nowait> <space>k  :<C-u>CocPrev<CR>
        " Resume latest coc list.
        nnoremap <silent><nowait> <space>p  :<C-u>CocListResume<CR>
    " }

    " Startup: {
        let g:dashboard_fzf_engine = 'ag'
        let g:dashboard_custom_header = [
        \ ' ███╗   ██╗ ███████╗ ██████╗  ██╗   ██╗ ██╗ ███╗   ███╗',
        \ ' ████╗  ██║ ██╔════╝██╔═══██╗ ██║   ██║ ██║ ████╗ ████║',
        \ ' ██╔██╗ ██║ █████╗  ██║   ██║ ██║   ██║ ██║ ██╔████╔██║',
        \ ' ██║╚██╗██║ ██╔══╝  ██║   ██║ ╚██╗ ██╔╝ ██║ ██║╚██╔╝██║',
        \ ' ██║ ╚████║ ███████╗╚██████╔╝  ╚████╔╝  ██║ ██║ ╚═╝ ██║',
        \ ' ╚═╝  ╚═══╝ ╚══════╝ ╚═════╝    ╚═══╝   ╚═╝ ╚═╝     ╚═╝',
        \]

        let g:dashboard_custom_shortcut={
        \ 'last_session'       : 'l s',
        \ 'find_history'       : 'r f',
        \ 'find_file'          : 'f f',
        \ 'new_file'           : 'n f',
        \ 'change_colorscheme' : 'c c',
        \ 'find_word'          : 'f w',
        \ 'book_marks'         : 'g m',
        \ }

        let g:dashboard_default_executive ='fzf'
        nnoremap <silent> <leader>nf :DashboardNewFile<CR>
        nnoremap <silent> <leader>ff :DashboardFindFile<CR>
        nnoremap <silent> <leader>fw :DashboardFindWord<CR>
        nnoremap <silent> <leader>rf :DashboardFindHistory<CR>
        nnoremap <silent> <Leader>cc :DashboardChangeColorscheme<CR>
        nnoremap <silent> <Leader>gm :DashboardJumpMark<CR>
        nmap <leader>ls :<C-u>SessionLoad<CR>
        nmap <leader>ss :<C-u>SessionSave<CR>
    " }

    function BGToggle()
        if (s:current_bg ==? "light")
            set background=dark
            colorscheme gruvbox
            let s:current_bg = "dark"
        else
            set background=light
            colorscheme default
            let s:current_bg = "light"
        endif
    endfunction

    set list " Enables the characters to be displayed.
    " Useful for showing trailing whitespace and others.
    set listchars=tab:›\ ,trail:•,extends:❯,precedes:❮,nbsp:_

    " CPP enhanced highlight: {
        let g:cpp_class_scope_highlight = 1
        let g:cpp_member_variable_highlight = 1
        let g:cpp_class_decl_highlight = 1
        let g:cpp_posix_standard = 1
        let g:cpp_experimental_template_highlight = 1
        let g:cpp_concepts_highlight = 1
    " }
" }

" Filetype: {
    filetype on
    filetype plugin on
    filetype indent on
    augroup project
        autocmd!
        autocmd BufRead,BufNewFile *.java set filetype=java | set foldmethod=syntax
        autocmd BufRead,BufNewFile *.h,*.c set filetype=c | set cindent | set foldmethod=syntax
        autocmd BufRead,BufNewFile *.hpp,*.cpp set filetype=cpp | set cindent | set foldmethod=syntax
        autocmd BufRead,BufNewFile *.go set filetype=go | set foldmethod=syntax
        autocmd BufRead,BufNewFile *.py let b:coc_root_patterns = ['.git', '.env'] | set foldmethod=indent
    augroup END

    " Ignore certain files and folders when globing
    set wildignore+=*.o,*.obj,*.dylib,*.bin,*.dll,*.exe
    set wildignore+=*/.git/*,*/.svn/*,*/__pycache__/*,*/build/**
    set wildignore+=*.jpg,*.png,*.jpeg,*.bmp,*.gif,*.tiff,*.svg,*.ico
    set wildignore+=*.pyc,*.pkl
    set wildignore+=*.DS_Store
    set wildignore+=*.aux,*.bbl,*.blg,*.brf,*.fls,*.fdb_latexmk,*.synctex.gz,*.xdv
    set wildignorecase
" }

" Mappings: {
    " Will remove latest search/replace highlight.
    nnoremap <silent> <C-L> :silent! nohl<cr><C-L>

    " Useful to toggle the NERDTree window back and forth.
    " Opens directory tree on the left side 
    noremap <silent> <leader>d :silent! NERDTreeToggle<cr>
    " Same thing as above, but for the TagBar plugin...
    " Opens list of tags on the right side
    noremap <silent> <leader>s :silent! TagbarToggle<cr>
    " For another window, this time for the GUndo tree.
    " Opens the undo history on the right side
    noremap <silent> <leader>g :silent! GundoToggle<cr>

    " Shortcut Ag searching.
    noremap <leader>f :Ack! <C-R>=expand("<cword>")<CR><CR>
    " Shortcut for Tabulate.
    noremap <leader>a :Tab /


    nnoremap <leader>nhs :nohlsearch<CR>
    nmap <leader>fe :set foldenable<CR>
    nmap <leader>fd :set nofoldenable<CR>

    " Toggle Background and colorscheme
    nmap <leader>bg :call BGToggle()<CR>

    " Save key bindings
    nmap <F2> :w<CR>
    imap <F2> <ESC>:w<CR>i
    nmap <F3> :mksession!<CR>
    imap <F3> <ESC>:mksession!<CR>i

    " Line number key bindings
    nmap <leader>sn :set number<CR>
    nmap <leader>sr :set relativenumber<CR>
    nmap <leader>snn :set nonumber <bar> set norelativenumber<CR>
    nmap <leader>snr :set norelativenumber<CR>

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
    nmap <leader>cws :%s/\s\+$//e<CR>


    " Set C indent
    nmap <leader>ci :set cindent<CR>
    imap <leader>ci <ESC>:set cindent<CR>i

    " Set FZF binding : Opens a fuzzy file search window.
    nmap <C-f> :FZF<CR>
    imap <C-f> :FZF<CR>

    " Set Emmet Binding
    nmap <C-p> <C-y>,
    imap <C-p> <C-y>,
" }
