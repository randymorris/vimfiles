" Modularized configuration for vim
" Randy Morris <randy.morris@archlinux.us>

" Auto Commands

silent! autocmd BufReadPost * call RestoreCursorPos()
silent! autocmd BufWinEnter * call OpenFoldOnRestore()
