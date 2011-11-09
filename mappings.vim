" Modularized configuration for vim
" Randy Morris <randy.morris@archlinux.us>
"
" Keybinds

let mapleader='\'

"{{{ Command Line
cnoremap <enter> <c-\>eCommandLineSubstitute()<enter><enter>
let g:command_line_substitutes = [
    \ ['^ee \(.\+\)', 'e **/\1*'],
    \ ['^ack ', 'Ack! '],
    \ ['^h ', 'vertical help '],
\]
"}}}

"{{{ Insert
map! jj <esc>
inoremap {<enter> {<enter>}<c-o>O
inoremap [<enter> [<enter>]<c-o>O
inoremap (<enter> (<enter>)<c-o>O
"}}}

"{{{ Normal
nnoremap <leader>W :match TODO /\%80v.\+/<enter>
nnoremap <silent> <leader>L :setlocal invlist<enter>
nnoremap <silent> <leader>N :setlocal invnumber<enter>
nnoremap <silent> <leader>R :setlocal invrelativenumber<enter>
nnoremap gV `[v`]
nnoremap K 0"_d$
nnoremap q/ <nop>
nnoremap q: <nop>
nnoremap q? <nop>

for i in [1,2,3,4,5,6,7,8,9]
    execute "silent! nnoremap <leader>".i." :buffer! ".i."<enter>"
    execute "silent! nnoremap <leader>s".i." :sbuffer! ".i."<enter>"
    execute "silent! nnoremap <leader>v".i." :vertical sbuffer! ".i."<enter>"
    execute "silent! nnoremap <leader>z".i." :set foldlevel=".i."<enter>"
endfor

if &diff
    nnoremap du :wincmd w <bar> undo <bar> wincmd w <bar> diffupdate<enter>
    nnoremap u :undo <bar> diffupdate<enter>
    nnoremap <space> :normal! ]c<enter>
    nnoremap <backspace> :normal! [c<enter>
endif
"}}}

"{{{ Visual
if &diff
    vnoremap p :diffput <bar> diffupdate<enter>
    vnoremap o :diffget <bar> diffupdate<enter>
endif
"}}}
