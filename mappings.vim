" Modularized configuration for vim
" Randy Morris <randy.morris@archlinux.us>
"
" Keybinds

let mapleader=','

"{{{ Insert
map! jj <esc>
inoremap {<enter> {<enter>}<c-o>O
inoremap [<enter> [<enter>]<c-o>O
inoremap (<enter> (<enter>)<c-o>O
"}}}

"{{{ Normal
nnoremap <leader>L :setlocal invlist<enter>
nnoremap <leader>N :setlocal invnumber<enter>
nnoremap <leader>W :match TODO /\%80v.\+/<enter>
nnoremap gV `[v`]
nnoremap K 0"_d$
nnoremap q/ <nop>
nnoremap q: <nop>
nnoremap q? <nop>

nnoremap <leader>ff :e **/*<left>
nnoremap <leader>fp :<c-p><left>

for i in [1,2,3,4,5,6,7,8,9]
    execute "silent! nnoremap <leader>".i." :buffer! ".i."<enter>"
    execute "silent! nnoremap <leader>s".i." :sbuffer! ".i."<enter>"
    execute "silent! nnoremap <leader>v".i." :vertical sbuffer! ".i."<enter>"
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


"{{{ Everywhere
map <f1> <nop>
lmap <f1> <nop>
map <s-up> <nop>
lmap <s-up> <nop>
map <s-down> <nop>
lmap <s-down> <nop>
"}}}
