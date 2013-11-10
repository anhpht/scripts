"func! Prompt_file(files_list)
"    for F in a:files_list
"        if F != ""
"            let A = input("Open: ".F." ? (y/n)")
"            if (A == "y") || (A == '')
"                return F
"            endif
"        endif
"    endfor
"endfunc
"
"func! FindF()
"    let filename = input("File name: ")
"    if filename != ""
"        let matchline=system("tail -n 100 $HOME/.e_history | grep -E \"emacs|vim\" | awk '{ print $NF }' | grep ".filename." |tail -n 1")
"        let file = substitute(matchline, '\n','',"g")
"        let Hist_file = Prompt_file([file])
"        if (Hist_file != "0")
"            :execute "e " . fnameescape(Hist_file)
"        else
"            let files = system("find . -name \\*".filename."\\*|grep -v .svn")
"            let files_list = split(files, '\n')
"            if len(files_list) == 1
"                :execute "e " . fnameescape(get(files_list, 0))
"            else
"                let ConfirmName = Prompt_file(files_list)
"                if ConfirmName != "0"
"                    :execute "e " . fnameescape(ConfirmName)
"                endif
"            endif
"        endif
"    endif
"endfunc
"cmap F :call FindF()
