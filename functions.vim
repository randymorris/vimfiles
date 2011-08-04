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

"{{{ Be lazy and 'remap' lowercase commands
"
" Expects a list g:command_line_substitutes which contains two element
" lists of regular expressions which are used as search and replace
" expressions that are completed on the current command line text before
" executing it.
function! CommandLineSubstitute()
    let cl = getcmdline()
    if exists('g:command_line_substitutes')
        for [k, v] in g:command_line_substitutes
            if match(cl, k) == 0
                let cl = substitute(cl, k, v, "")
                break
            endif
        endfor
    endif
    return cl
endfunction
"}}}
