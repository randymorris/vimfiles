" Modularized configuration for vim
" Randy Morris <randy.morris@archlinux.us>

" Functions

function! OpenFoldOnRestore() "{{{
    if exists("b:doopenfold")
        execute "normal zv"
        if(b:doopenfold > 1)
            execute "+".1
        endif
        unlet b:doopenfold
    endif
endfunction
"}}}

function! RestoreCursorPos() "{{{
    if expand("<afile>:p:h") !=? $TEMP
        if line("'\"") > 1 && line("'\"") <= line("$")
            let line_num = line("'\"")
            let b:doopenfold = 1
            if (foldlevel(line_num) > foldlevel(line_num - 1))
                let line_num = line_num - 1
                let b:doopenfold = 2
            endif
            execute line_num
        endif
    endif
endfunction
"}}}
