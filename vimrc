"General setting
set expandtab
set shiftwidth=4
set softtabstop=4
set smarttab
set noswapfile
set hlsearch
set hid
set laststatus=2
set statusline=\ %F%m%r%h\ %w\ \ \ Line:\ %l/%L:%c
set pt=<f9>
set nocompatible
set number
set ignorecase
set smartcase
set csprg='/usr/bin/cscope'
filetype plugin indent on
syntax on
colorscheme aqua
set clipboard=unnamed
let g:xml_syntax_folding=1
autocmd BufEnter * silent! lcd %:p:h

"Filetype mapping
au! BufNewFile,BufRead *.csv,*.tsv,*.psv setf csv
"au BufNewFile,BufRead *.txt setlocal ft=fortran
au BufNewFile,BufRead *.src setlocal ft=fortran
au BufNewFile,BufRead *.log setlocal ft=lisp
au BufNewFile,BufRead *.old setlocal ft=c
au BufNewFile,BufRead *.new setlocal ft=c
au BufRead /tmp/mutt-* set tw=72
au FileType xml setlocal foldmethod=syntax

".pdf
autocmd BufReadPre *.pdf set ro nowrap
autocmd BufReadPost *.pdf silent %!pdftotext "%" -nopgbrk -layout -q -eol unix -

".doc
autocmd BufReadPre *.doc set ro
autocmd BufReadPost *.doc %!antiword "%"

".docx
autocmd BufReadPre *.docx set ro
autocmd BufReadPost *.docx %!docx2txt.pl "%" -

".xls
autocmd BufReadPre *.xls set ro | setf csv
autocmd BufReadPost *.xls silent! %!xls2csv -q -x "%" -c -
autocmd BufReadPost *.xls redraw

au BufRead,BufWritePost *.csv,*.xls :%ArrangeColumn
au BufWritePre *.csv,*.xls :%UnArrangeColumn
"let g:csv_autocmd_arrange = 1

"Common shortcuts 
map <right> :bn <enter>
map <left> :bp <enter>
map , :
map <C-c> I% <Esc>
imap ii <Esc>
map <tab> I <tab> <Esc>
map gt :VimwikiTable<space>

"NERDTree
"let g:Tlist_Auto_Open = 1
map gn :NERDTreeToggle<CR>
":NERDTree<CR>
":NERDTreeClose<CR>

"Tagslist 
let g:Tlist_Use_Right_Window = 1
map gl :TlistToggle<CR>
":TlistOpen
":TlistClose
map <C-L> <C-W>l<C-W>_
map <C-H> <C-W>h<C-W>_
vmap // y/<C-R>"<CR>
nmap <Leader>s :source ~/.vimrc<cr>
nmap <Leader>v :e ~/.vimrc<cr>
