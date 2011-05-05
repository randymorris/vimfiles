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
nmap <leader>L :setl invlist<cr>
nmap <leader>N :setl invnumber<cr>
nmap <leader>W :mat TODO /\%80v.\+/<cr>
nnoremap gV `[v`]
nnoremap q/ <nop>
nnoremap q: <nop>
nnoremap q? <nop>
for i in [1,2,3,4,5,6,7,8,9]
    execute "silent! nnoremap <leader>".i." :buffer! ".i."<cr>"
    execute "silent! nnoremap <leader>s".i." :sbuffer! ".i."<cr>"
    execute "silent! nnoremap <leader>v".i." :vertical sbuffer! ".i."<cr>"
endfor
"}}}
