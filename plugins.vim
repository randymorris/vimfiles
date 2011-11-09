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
Bundle "kien/ctrlp.vim"
Bundle "tpope/vim-endwise"
Bundle "mattn/gist-vim"
Bundle "AndrewRadev/linediff.vim"
Bundle "tpope/vim-markdown"
Bundle "scrooloose/nerdcommenter"
Bundle "bingaman/vim-sparkup"
Bundle "tpope/vim-surround"
Bundle "gmarik/vundle"
"}}}

"{{{ Plugin specific settings
"{{{2 Bufstat settings
highlight BufferNC ctermfg=248 ctermbg=239
highlight link Buffer StatusLine
let g:bufstat_active_hl_group = 'Buffer'
let g:bufstat_inactive_hl_group = 'BufferNC'
let g:bufstat_prevent_mappings = 1
"}}}
"{{{2 Gist settings
let g:gist_private = 1
let g:gist_detect_filetype = 1
"}}}
"{{{2 NERD Commenter settings
let NERDCreateDefaultMappings = 0
let NERDCommentWholeLinesInVMode = 1
let NERDSpaceDelims = 1
map <leader>c <plug>NERDCommenterToggle
"}}}
"}}}
"{{{2 CtrlP settings
let g:ctrlp_map = '-'
let g:ctrlp_use_caching = 1
let g:ctrlp_persistent_input = 0
let g:ctrlp_cache_dir = $HOME . "/.vim/tmp"
"}}}

filetype plugin indent on
