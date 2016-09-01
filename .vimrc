" General setting
set title
set showcmd
set noswapfile
set incsearch
set hlsearch
set hid
set mouse=r
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
set mat=5                                             " Bracket blinking.
set list
set novisualbell                                      " No blinking .
set noerrorbells                                      " No noise.
set background=dark

set wildmenu
set ttyfast

setlocal fo+=aw
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
set softtabstop=8
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
"map , :
map <C-L> <C-W>l<C-W>_
map <C-H> <C-W>h<C-W>_
map <C-K> <C-W>k
map <C-J> <C-W>j
map T :Man <C-R><C-W><CR>
map F :cs f f<space>
map S :cs f s<space>

" Insert mode shortcuts
imap ii <Esc>

" Visual mode shortcuts
vmap // y/<C-R>"<CR>
vmap /s y:cs f s <C-R>"<CR>
vmap /f y:cs f f <C-R>"<CR>
vmap /g y:cs f g <C-R>"<CR>
vmap /e y:cs f e <C-R>"<CR>
vmap /i y:cs f i <C-R>"<CR>
vmap /c y:cs f c <C-R>"<CR>

" Plugins, tools
let g:Tlist_Ctags_Cmd = "/usr/bin/ctags"
let tlist_cpp_settings = 'c++;c:class;f:function'
map gl :TlistToggle<CR>

set csprg='/usr/bin/cscope'
runtime ftplugin/man.vim

" Python
let g:pydiction_location = '/usr/share/pydiction/complete-dict'

" Ranger Chooser
fun! RangerChooser()
    exec "silent !ranger --choosefile=/tmp/chosenfile " . expand("%:p:h")
    if filereadable('/tmp/chosenfile')
        exec 'edit ' . system('cat /tmp/chosenfile')
        call system('rm /tmp/chosenfile')
    endif
    redraw!
endfun
let mapleader = ","
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

autocmd BufRead,BufNewFile *mutt-*   setfiletype mail

au BufRead,BufNewFile **.m set makeprg=goc\ %\ -o\ %<
au BufRead,BufNewFile **.swift set makeprg=swiftc\ %\ -o\ %<
au FileType c set makeprg=gcc\ %\ -o\ %<
au FileType cpp set makeprg=g++\ %\ -o\ %<
map <Leader>c :cs find c <C-R>=expand("<cword>")<CR><CR>
map <Leader>e :cs find e <C-R>=expand("<cword>")<CR><CR>
map <Leader>f :cs find f <C-R>=expand("<cfile>")<CR><CR>
map <Leader>i :cs find i <C-R>=expand("<cfile>")<CR><CR>
map <Leader>s :cs find s <C-R>=expand("<cfile>")<CR><CR>
"colorscheme aqua
"colorscheme molokai
"colorscheme holokai
"colorscheme darkZ
"colorscheme dawn
"colorscheme dante
colorscheme emacs
"colorscheme desert
"colorscheme sorcerer
"colorscheme solarized
"colorscheme transparent
"colorscheme tango2
"set cursorline
