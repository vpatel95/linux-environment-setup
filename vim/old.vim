" NeoVIM Configuration file
" Author    : Ved Patel
" Date      : 21 December 2022

    let s:current_bg = "dark"

    " Nerdtree: {
    autocmd FileType nerdtree setlocal relativenumber
    " }

    " AutoCompletion: {
        inoremap <silent><expr> <TAB>
                    \ coc#pum#visible() ? coc#pum#next(1) :
                    \ CheckBackspace() ? "\<Tab>" :
                    \ coc#refresh()

        inoremap <expr><UP> coc#pum#visible() ? coc#pum#prev(1) : "\<UP>"
        inoremap <expr><DOWN> coc#pum#visible() ? coc#pum#next(1) : "\<DOWN>"

        " Make <CR> to accept selected completion item or notify coc.nvim to format
        " <C-g>u breaks current undo, please make your own choice
        inoremap <silent><expr> <CR> coc#pum#visible() ? coc#pum#confirm()
                    \: "\<C-g>u\<CR>\<c-r>=coc#on_enter()\<CR>"

        function! CheckBackspace() abort
            let col = col('.') - 1
            return !col || getline('.')[col - 1]  =~# '\s'
        endfunction

        function! s:show_documentation()
            if (index(['vim','help'], &filetype) >= 0)
                execute 'h '.expand('<cword>')
            else
                call CocAction('doHover')
            endif
        endfunction

        augroup CocGroup
            autocmd!
            " Update signature help on jump placeholder
            autocmd User CocJumpPlaceholder call CocActionAsync('showSignatureHelp')
        augroup end

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
        autocmd BufRead,BufNewFile *cc,*hh,*.hpp,*.cpp set filetype=cpp | set cindent | set foldmethod=syntax
        autocmd BufRead,BufNewFile *.go set filetype=go | set foldmethod=syntax
        autocmd BufRead,BufNewFile *.py let b:coc_root_patterns = ['.git', '.env'] | set foldmethod=indent
        autocmd BufRead,BufNewFile *.aliases set filetype=sh | set foldmethod=indent
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
    noremap <silent> <leader>d :silent! NvimTreeToggle<cr>
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

    nmap <leader>fw :Ag<CR>
    imap <leader>fw :Ag<CR>

    " Set Emmet Binding
    nmap <C-p> <C-y>,
    imap <C-p> <C-y>,

    " Coc mappings
    inoremap <silent><expr> <C-Space> coc#refresh()

    nmap <silent> [c <Plug>(coc-diagnostic-prev)
    nmap <silent> ]c <Plug>(coc-diagnostic-next)

    nmap <silent> gd :call CocAction('jumpDefinition')<CR>
    nmap <silent> vd :call CocAction('jumpDefinition', 'vsplit')<CR>
    nmap <silent> sd :call CocAction('jumpDefinition', 'split')<CR>

    nmap <silent> gg :call CocAction('jumpDeclaration')<CR>
    nmap <silent> vg :call CocAction('jumpDeclaration', 'vsplit')<CR>
    nmap <silent> sg :call CocAction('jumpDeclaration', 'split')<CR>

    nmap <silent> gt :call CocAction('jumpTypeDefinition')<CR>
    nmap <silent> vt :call CocAction('jumpTypeDefinition', 'vsplit')<CR>
    nmap <silent> st :call CocAction('jumpTypeDefinition', 'split')<CR>

    nmap <silent> gr :call CocAction('jumpUsed')<CR>
    nmap <silent> vr :call CocAction('jumpUsed', 'vsplit')<CR>
    nmap <silent> sr :call CocAction('jumpUsed', 'split')<CR>

    nmap <silent> hd :call CocAction('definitionHover')<CR>

    nnoremap <silent> K :call <SID>show_documentation()<CR>

    nnoremap <silent><nowait> <space>a  :<C-u>CocList diagnostics<cr>
    nnoremap <silent><nowait> <space>e  :<C-u>CocList extensions<cr>
    nnoremap <silent><nowait> <space>c  :<C-u>CocList commands<cr>
    nnoremap <silent><nowait> <space>o  :<C-u>CocList outline<cr>
    nnoremap <silent><nowait> <space>s  :<C-u>CocList symbols<cr>
    nnoremap <silent><nowait> <space>j  :<C-u>CocNext<CR>
    nnoremap <silent><nowait> <space>k  :<C-u>CocPrev<CR>
    nnoremap <silent><nowait> <space>p  :<C-u>CocListResume<CR>

    " Match Up
    nnoremap <silent><nowait> <space>w :<c-u>MatchupWhereAmI?<cr>

" }
