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

"{{{ Used for tmux integration
"
" Allows window motion commands to break out of vim and move to an
" adjacent tmux pane.
function! SwitchToWindow(direction)
    let old_winnr = winnr()
    execute "wincmd " . a:direction

    if old_winnr != winnr() || expand("$TMUX") == "$TMUX"
        return
    endif

    if a:direction == "h"
        let arg = "L"
    elseif a:direction == "j"
        let arg = "D"
    elseif a:direction == "k"
        let arg = "U"
    elseif a:direction == "l"
        let arg = "R"
    endif

    call system("tmux select-pane -" . arg)
endfunction
"}}}
