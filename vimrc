" General setting
set noswapfile
set incsearch
set hlsearch
set hid
set laststatus=2
set statusline=\ %F%m%r%h\ %w\ \ \ Line:\ %l/%L:%c
set pt=<f5>
set encoding=utf-8
set nocompatible           "no compatiple with vi
set ignorecase
set smartcase
set backspace=indent,eol,start  " allow backspacing over everything in insert mode
set ruler		   " show the cursor position all the time
set showcmd		   " display incomplete commands
set clipboard=unnamed
set showmatch               " Show matching brackets.
set mat=5  " Bracket blinking.
set list
set novisualbell            " No blinking .
set noerrorbells            " No noise.
set background=dark
colorscheme aqua
filetype plugin indent on
syntax on

" Formatting
set lcs=tab:\ \ ,eol:\ \,trail:~,extends:>,precedes:< " Show $ at end of line and trailing space as ~
set ts=4  " Tabs are 4 spaces
set bs=2  " Backspace over everything in insert mode
set number
set wrap
set expandtab
set shiftwidth=4
set softtabstop=4
set smarttab
set cinoptions=:0,p0,t0
set cinwords=if,else,while,do,for,switch,case
set formatoptions=tcqr
set cindent
set autoindent
set smartindent
set textwidth=500
set tabstop=4
set lbr

"Filetype mapping
au! BufNewFile,BufRead *.csv,*.tsv,*.psv setf csv
au BufNewFile,BufRead *.log setlocal ft=lisp
au BufNewFile,BufRead *.old setlocal ft=c
au BufNewFile,BufRead *.new setlocal ft=c
au BufRead /tmp/mutt-* set tw=80
au BufEnter * if &filetype == 'help' | :only | endif
"au BufEnter * :only

" Choose the fold method depending of the file type and unfold when opening it
autocmd Syntax c,cpp,vim,xml,html,xhtml setlocal foldmethod=syntax
autocmd Syntax python setlocal foldmethod=indent
autocmd Syntax c,cpp,vim,xml,html,xhtml,perl,python normal zR

" Autocompletion
autocmd FileType python set omnifunc=pythoncomplete#Complete
autocmd FileType javascript set omnifunc=javascriptcomplete#CompleteJS
autocmd FileType html set omnifunc=htmlcomplete#CompleteTags
autocmd FileType css set omnifunc=csscomplete#CompleteCSS
autocmd FileType xml set omnifunc=xmlcomplete#CompleteTags
autocmd FileType c set omnifunc=ccomplete#Complete

" Read .pdf .doc .docx .xls
autocmd BufReadPre *.pdf set ro nowrap
autocmd BufReadPost *.pdf silent %!pdftotext "%" -nopgbrk -layout -q -eol unix -
autocmd BufReadPre *.doc set ro
autocmd BufReadPost *.doc %!antiword "%"
autocmd BufReadPre *.docx set ro
autocmd BufReadPost *.docx %!docx2txt.pl "%" -
autocmd BufReadPre *.xls set ro | setf csv
autocmd BufReadPost *.xls silent! %!xls2csv -q -x "%" -c -
autocmd BufReadPost *.xls redraw
au BufRead,BufWritePost *.csv,*.xls :%ArrangeColumn
au BufWritePre *.csv,*.xls :%UnArrangeColumn

"""""""""""""""""""""""""""""""""""""""""""""""""""
" Normal mode shortcuts
"""""""""""""""""""""""""""""""""""""""""""""""""""
map <right> :bn <enter>
map <left> :bp <enter>
map , :
map <C-c> I% <Esc>
map <tab> I <tab> <Esc>
map <C-L> <C-W>l<C-W>_
map <C-H> <C-W>h<C-W>_
map <C-K> <C-W>k
map <C-J> <C-W>j
map T :Man <C-R><C-W><CR>

" NERDTree Vimwikitable Explore
map gn :NERDTreeToggle<CR>
map gt :VimwikiTable<space>
nnoremap <silent> <Leader>e :Explore<CR>

" TagsList
" let g:loaded_ccase = 1
let g:Tlist_Ctags_Cmd = "/usr/bin/ctags"
let g:Tlitst_Use_Right_Window = 1
let g:pydiction_location = '/usr/share/pydiction/complete-dict'

map gl :TlistToggle<CR>

" Ranger Chooser
fun! RangerChooser()
    exec "silent !ranger --choosefile=/tmp/chosenfile " . expand("%:p:h")
    if filereadable('/tmp/chosenfile')
        exec 'edit ' . system('cat /tmp/chosenfile')
        call system('rm /tmp/chosenfile')
    endif
    redraw!
endfun
map <Leader>r :call RangerChooser()<CR>

" Smart Home
function! SmartHome()
    let s:col = col(".")
    normal! ^
    if s:col == col(".")
        normal! 0
    endif
endfunction
nnoremap <silent> <Home> :call SmartHome()<CR>
inoremap <silent> <Home> <C-O>:call SmartHome()<CR>

"""""""""""""""""""""""""""""""""""""""""""""""""""
" Insert mode shortcuts
"""""""""""""""""""""""""""""""""""""""""""""""""""
inoremap <C-U> <C-G>u<C-U>
imap ii <Esc>

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Visual mode shortcuts
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
vmap // y/<C-R>"<CR>


"""""""""""""""""""""""""""""""""""""""""""""""""""
" Set the dictionaries
set complete +=k
set dictionary=~/.vim/dict/*  "/usr/share/dict/*

" Makes all types of completions!!
let g:SuperTabDefaultCompletionType = "context"
let g:SuperTabContextDefaultCompletionType = "<c-n>" " for spell correction <c-x>s or for thesaurus <c-x><c-t>

set csprg='/usr/bin/cscope'
autocmd bufwritepost vimrc source ~/.vimrc  " When vimrc is edited, reload it!
runtime ftplugin/man.vim
