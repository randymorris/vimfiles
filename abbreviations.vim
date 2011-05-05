" Modularized configuration for vim
" Randy Morris <randy.morris@archlinux.us>

" Abbreviations

cabbrev h h<c-\>esubstitute(getcmdline(), '^h\>', 'Help', '')<cr>
cabbrev w!! w !sudo tee % > /dev/null<cr>:e!<cr><cr>
