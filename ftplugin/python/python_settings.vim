" Allow jumping to stdlib tags
" Note: regenerate tags file with the following:
"       ctags -R -f ~/.vim/tags/python.ctags /usr/lib/pythonX.X
set tags+=$HOME/.vim/tags/python.ctags

" Show line number in gvim only
if has('gui_running')
    set number
    set numberwidth=1
endif

setlocal expandtab
setlocal shiftwidth=4
setlocal tabstop=4
setlocal softtabstop=4
setlocal formatoptions+=croq

let python_highlight_all=1
let python_highlight_exceptions=1
let python_highlight_builtins=1
