" General setting
set title
set showcmd
set noswapfile
set incsearch
set hlsearch
set hid
set laststatus=2
set statusline=\ %F%m%r%h\ %w\ \ \ Line:\ %l/%L:%c
set pt=<f5>
set encoding=utf-8
set nocompatible                                      " No compatiple with vi
set ignorecase
set smartcase
set backspace=indent,eol,start                        " Allow backspacing over everything in insert mode
set ruler                                             " Show the cursor position all the time
set clipboard=unnamed
set showmatch                                         " Show matching brackets.
set cursorline
set mat=5                                             " Bracket blinking.
set list
set novisualbell                                      " No blinking .
set noerrorbells                                      " No noise.
set background=dark
set autochdir
filetype plugin on
filetype indent on
syntax on

" Formatting
set lcs=tab:\ \ ,eol:\ \,trail:~,extends:>,precedes:< " Show $ at end of line and trailing space as ~
set ts=4                                              " Tabs are 4 spaces
set bs=2                                              " Backspace over everything in insert mode
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
set lbr

" Normal mode shortcuts
map <right> :bn <enter>
map <left> :bp <enter>
map , :
map <C-L> <C-W>l<C-W>_
map <C-H> <C-W>h<C-W>_
map <C-K> <C-W>k
map <C-J> <C-W>j
map T :Man <C-R><C-W><CR>

nnoremap <silent> <Leader>e :Explore<CR>

" Insert mode shortcuts
inoremap <C-U> <C-G>u<C-U>
imap ii <Esc>

" Visual mode shortcuts
vmap // y/<C-R>"<CR>

" Plugins, tools
let g:Tlist_Ctags_Cmd = "/usr/bin/ctags"
set tags+=/mnt/data/tmp/omniorb/tags
let tlist_cpp_settings = 'c++;c:class;f:function'
map gl :TlistToggle<CR>

set csprg='/usr/bin/cscope'
runtime ftplugin/man.vim
autocmd bufwritepost vimrc source ~/.vimrc  " When vimrc is edited, reload it!

" Python
" let g:pydoc_open_cmd = 'tabnew'
let g:pydiction_location = '/usr/share/pydiction/complete-dict'
map ? :Pydoc <C-R><C-W><CR>

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

" Filetype mapping
" au! BufNewFile,BufRead *.csv,*.tsv,*.psv setf csv
" au BufNewFile,BufRead *.log setlocal ft=lisp
" au BufNewFile,BufRead *.old setlocal ft=c
" au BufNewFile,BufRead *.new setlocal ft=c
" au BufRead /tmp/mutt-* set tw=80
" au BufEnter * if &filetype == 'help' | :only | endif

" Choose the fold method depending of the file type and unfold when opening it
" autocmd Syntax c,cpp,vim,xml,html,xhtml setlocal foldmethod=syntax
" autocmd Syntax python setlocal foldmethod=indent
" autocmd Syntax c,cpp,vim,xml,html,xhtml,perl,python normal zR

" Autocompletion
" autocmd FileType python set omnifunc=pythoncomplete#Complete
" autocmd FileType javascript set omnifunc=javascriptcomplete#CompleteJS
" autocmd FileType html set omnifunc=htmlcomplete#CompleteTags
" autocmd FileType css set omnifunc=csscomplete#CompleteCSS
" autocmd FileType xml set omnifunc=xmlcomplete#CompleteTags
" autocmd FileType c set omnifunc=ccomplete#Complete

" Read .pdf .doc .docx .xls
" autocmd BufReadPre *.pdf set ro nowrap
" autocmd BufReadPost *.pdf silent %!pdftotext "%" -nopgbrk -layout -q -eol unix -
" autocmd BufReadPre *.doc set ro
" autocmd BufReadPost *.doc %!antiword "%"
" autocmd BufReadPre *.docx set ro
" autocmd BufReadPost *.docx %!docx2txt.pl "%" -

" Compile source
" au FileType C set makeprg=gcc\ %
" au FileType Cpp set makeprg=g++\ %

" colorscheme Darkside
" colorscheme aqua
colorscheme molokai
" colorscheme holokai
" colorscheme monokai
" colorscheme darkZ
" colorscheme dawn
"  colorscheme dante
map <C-F12> :!ctags -R --c++-kinds=+p --fields=+iaS --extra=+q .<CR>
