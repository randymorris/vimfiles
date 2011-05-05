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
Bundle "Lokaltog/vim-easymotion"
Bundle "sjl/gundo.vim"
Bundle "sjbach/lusty"
Bundle "tpope/vim-markdown"
Bundle "scrooloose/nerdcommenter"
Bundle "ervandew/supertab"
Bundle "gmarik/vundle"
"}}}

"{{{ Ack settings
cabbrev ack ack<c-\>esubstitute(getcmdline(), '^ack\>', 'Ack!', '')<cr>
"}}}
"{{{ Bufstat settings
highlight BufferNC ctermfg=248 ctermbg=239
highlight link Buffer StatusLine
let g:bufstat_active_hl_group = 'Buffer'
let g:bufstat_inactive_hl_group = 'BufferNC'
"}}}
"{{{ Gundo settings
nmap <leader>U :GundoToggle<cr>
let g:gundo_preview_bottom = 1
let g:gundo_preview_height = 10
let g:gundo_width = 30
"}}}
"{{{ Lusty Explorer settings
nnoremap <leader><space> :LustyJuggler<cr>
nnoremap \ :LustyBufferExplorer<cr>
nnoremap <leader>\ :LustyFilesystemExplorer<cr> 
"}}}
"{{{ NERD Commenter settings
let NERDCreateDefaultMappings = 0
let NERDCommentWholeLinesInVMode = 1
let NERDSpaceDelims = 1
map <leader>c <plug>NERDCommenterToggle
"}}}
"{{{ Super Tab settings
let g:SuperTabDefaultCompletionType = "context"
let g:SuperTabMidWordCompletion = 0
"}}}

filetype plugin indent on
