" Modularized configuration for vim
" Randy Morris <randy.morris@archlinux.us>

" Abbreviations

cabbrev h h<c-\>esubstitute(getcmdline(), '^h\>', 'Help', '')<enter>
cabbrev w!! w !sudo tee % > /dev/null<enter>:e!<enter><enter>
