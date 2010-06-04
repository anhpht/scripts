let g:erlangFold=0
set expandtab
set shiftwidth=4
set softtabstop=4
set smarttab
set noswapfile
map <right> :bn <enter>
map <left> :bp <enter>
map , :
map <C-c> I% <Esc>
imap ii <Esc>
imap <F2> <Esc> :w <enter>
map <tab> I <tab> <Esc>
filetype plugin on
filetype indent on
syntax enable
set hlsearch
set hid
set pastetoggle=<F10>
set laststatus=2
set statusline=\ %F%m%r%h\ %w\ \ \ Line:\ %l/%L:%c

function! F2E_inline()
    let line = getline('.')
    let repl1 = substitute(line, "é", "e", "g")
    let repl2 = substitute(repl1, "è", "e", "g")
    let repl1 = substitute(repl2, "ù", "u", "g")
    let repl2 = substitute(repl1, "’", "'", "g")
    let repl1 = substitute(repl2, "€", "E", "g")
    let repl2 = substitute(repl1, "à", "a", "g")
    let repl1 = substitute(repl2, "»", ">>", "g")
    let repl2 = substitute(repl1, "ç", "c", "g")
    let repl1 = substitute(repl2, "n°", "n0", "g")
    let repl_last = substitute(repl1, "…", "...", "g")
    if repl_last != line
        call setline('.', repl_last)
    endif
endfunc
func! F2E()
    let Pos = getpos('.')
    :1,$call F2E_inline()
    call setpos('.', Pos)
endfunc
map <F5> :call F2E() <cr>
function! EmptyString()
    let line = getline('.')
    let Start = stridx(line, '"')
    let End = strridx(line, '"')
    let str1 = strpart(line, 0, Start+1)
    let str2 = strpart(line, End, strlen(line)) 
    let str = str1.str2
    if str != line
        call setline('.', str)
    endif
endfunc
map <F2> :call EmptyString() <cr>
cmap <F2> :call EmptyString() 

func! Prompt_file(files_list)
    for F in a:files_list
        if F != ""
            let A = input("Open: ".F." ? (y/n)")
            if (A == "y") || (A == '')
                return F
            endif
        endif
    endfor
endfunc

func! FindF()
    let filename = input("File name: ")
    if filename != ""
        let matchline=system("tail -n 100 $HOME/.e_history | grep -E \"emacs|vim\" | awk '{ print $NF }' | grep ".filename." |tail -n 1")
        let file = substitute(matchline, '\n','',"g")
        let Hist_file = Prompt_file([file])
        if (Hist_file != "0")
            :execute "e " . fnameescape(Hist_file)
        else
            let files = system("find . -name \\*".filename."\\*|grep -v .svn")
            let files_list = split(files, '\n')
            if len(files_list) == 1
                :execute "e " . fnameescape(get(files_list, 0))
            else
                let ConfirmName = Prompt_file(files_list)
                if ConfirmName != "0"
                    :execute "e " . fnameescape(ConfirmName)
                endif
            endif
        endif
    endif
endfunc
cmap ff :call FindF()<cr>

func! FindTag()
    let line = getline('.')
    let filter_line= substitute(line, "[^A-Za-z0-9 _ :]", " ", "g")
    let col = col('.')
    let str1 = strpart(filter_line, 0, col)
    let str2 = strpart(filter_line, col, strlen(line)) 
    let Start= strridx(str1, " ")
    let End= stridx(str2, " ") + col
    let module_func=strpart(line, Start+1, End-Start-1)
    if stridx(module_func, ":") > 0
        let [Module, Func] = split(module_func, ':')
        let vimsearch = findfile(Module.".erl",".")
        if vimsearch != ""
            :execute "e " . fnameescape(vimsearch)
        else
            let matchline= system("find . -name ".Module.".erl|grep -v .svn")
            let filepath = substitute(matchline, '\n','',"g")
            :execute "e " . fnameescape(filepath)
        endif
        let [Buf, tmp_lnum, tmp_col, Off]=getpos('.')
        let [Lnum, Col] = searchpos("^".Func, 'n')
        call setpos('.', [Buf, Lnum, Col, Off])
    else
        let [Buf, tmp_lnum, tmp_col, Off]=getpos('.')
        let [Lnum, Col] = searchpos("^".module_func, 'n')
        call setpos('.', [Buf, Lnum, Col, Off])
    endif
endfunc 
map <C-]> :call FindTag()<cr>
map <C-T> :bd<cr>
