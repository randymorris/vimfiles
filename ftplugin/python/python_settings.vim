" Allow jumping to stdlib tags
" Note: regenerate tags file with the following:
"       ctags -R -f ~/.vim/tags/python.ctags /usr/lib/pythonX.X
set tags+=$HOME/.vim/tags/python.ctags

" Show line number in gvim only
if has('gui_running')
    set number
    set numberwidth=1
endif
