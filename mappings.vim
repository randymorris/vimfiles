" Modularized configuration for vim
" Randy Morris <randy.morris@archlinux.us>
"
" Keybinds

let mapleader=','

"{{{ Command-line
cnoremap jj <esc>
"}}}

"{{{ Insert
inoremap jj <esc>
inoremap {<cr> {<cr>}<c-o>O<tab>
inoremap [<cr> [<cr>]<c-o>O<tab>
inoremap (<cr> (<cr>)<c-o>O<tab>
"}}}

"{{{ Normal
nnoremap <leader>L :setlocal invlist<cr>
nnoremap <leader>N :setlocal invnumber<cr>
nnoremap <leader>W :match TODO /\%80v.\+/<cr>
nnoremap gV `[v`]
nnoremap q/ <nop>
nnoremap q: <nop>
nnoremap q? <nop>

nnoremap <silent> <C-w>h :call SwitchToWindow('h')<cr>
nnoremap <silent> <C-w>j :call SwitchToWindow('j')<cr>
nnoremap <silent> <C-w>k :call SwitchToWindow('k')<cr>
nnoremap <silent> <C-w>l :call SwitchToWindow('l')<cr>

for i in [1,2,3,4,5,6,7,8,9]
    execute "silent! nnoremap <leader>".i." :buffer! ".i."<cr>"
    execute "silent! nnoremap <leader>s".i." :sbuffer! ".i."<cr>"
    execute "silent! nnoremap <leader>v".i." :vertical sbuffer! ".i."<cr>"
endfor

if &diff
    nnoremap du :wincmd w <bar> undo <bar> wincmd w <bar> diffupdate<cr>
    nnoremap u :undo <bar> diffupdate<cr>
    nnoremap <space> :normal! ]c<cr>
    nnoremap <backspace> :normal! [c<cr>
endif
"}}}

"{{{ Visual
if &diff
    vnoremap p :diffput <bar> diffupdate<cr>
    vnoremap o :diffget <bar> diffupdate<cr>
endif
"}}}
