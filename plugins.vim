" Modularized configuration for vim
" Randy Morris <randy.morris@archlinux.us>

" Plugins

if v:version < 700
    finish
endif

" {{{ Vundle setup
if !isdirectory(expand("~/.vim/bundle/vundle/.git"))
    !git clone https://github.com/gmarik/vundle ~/.vim/bundle/vundle
endif

filetype off
set runtimepath+=~/.vim/bundle/vundle/
call vundle#rc()
"}}}

"{{{ Bundles
Bundle "mileszs/ack.vim"
Bundle "rson/vim-bufstat"
Bundle "Raimondi/delimitMate"
Bundle "tpope/vim-endwise"
Bundle "tpope/vim-markdown"
Bundle "scrooloose/nerdcommenter"
Bundle "gmarik/vundle"
"}}}

"{{{ Ack settings
cabbrev ack ack<c-\>esubstitute(getcmdline(), '^ack\>', 'Ack!', '')<enter>
"}}}
"{{{ Bufstat settings
highlight BufferNC ctermfg=248 ctermbg=239
highlight link Buffer StatusLine
let g:bufstat_active_hl_group = 'Buffer'
let g:bufstat_inactive_hl_group = 'BufferNC'
"}}}
"{{{ NERD Commenter settings
let NERDCreateDefaultMappings = 0
let NERDCommentWholeLinesInVMode = 1
let NERDSpaceDelims = 1
map <leader>c <plug>NERDCommenterToggle
"}}}

filetype plugin indent on
