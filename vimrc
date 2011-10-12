" Minified Configuration for vim
" Randy Morris <randy.morris@archlinux.us>

" Settings

"{{{ General behavior
filetype plugin indent on
set autowrite
set backspace=2
set formatoptions=cornql
set hidden
set nosplitbelow
set splitright
set suffixes+=.pyc
"}}}

"{{{ Folding
silent! set foldcolumn=0
silent! set foldenable
silent! set foldlevel=10
silent! set foldmarker={{{,}}}
silent! set foldmethod=marker
silent! set foldopen-=search
silent! set foldopen-=undo
"}}}

"{{{ GUI
silent! set guifont=Monaco
silent! set guioptions=
"}}}

"{{{ Tabs
set autoindent
set expandtab
set shiftwidth=4
set smarttab
set tabstop=4
"}}}

"{{{ Temp files
set backup
set backupdir=~/.vim/tmp/
silent! set undodir=~/.vim/tmp/
silent! set undofile
"}}}

"{{{ Mouse
silent! set mouse=a
silent! set ttymouse=xterm
"}}}

"{{{ General display
set display+=lastline
set fillchars=
set laststatus=2
set list
set listchars=tab:⇥\ ,trail:·,extends:→,precedes:←,eol:↲
set novisualbell
set nowrap
set showbreak=↳\ 
set showmatch
set statusline=(%{strlen(&ft)?&ft:'?'},%{&fenc},%{&ff})\ \ %-9.(%l,%c%V%)\ \ %<%P
silent! set numberwidth=1
set wildmenu
set wildignore=*.pyc
set wildmode=longest,full
set completeopt=longest,menu
"}}}

"{{{ Colors
set background=dark
silent! colorscheme desert
silent! colorscheme xoria256-mod
syntax on
"}}}


" Source supporting files in order

silent! runtime abbreviations.vim
silent! runtime autocmds.vim
silent! runtime functions.vim
silent! runtime mappings.vim
silent! runtime plugins.vim

" vim: fdl=0
