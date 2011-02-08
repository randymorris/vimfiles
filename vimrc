" .vimrc - main ViM settings file
"
" Randy Morris (rson451@gmail.com)
"
" CREATED:  2008-08-18 22:31
" MODIFIED: 2011-02-08 12:38

" Setup Pathogen "{{{
" supress errors if < vim 7
silent! call pathogen#runtime_append_all_bundles()
silent! call pathogen#helptags()
filetype off
"}}}

" Simple Settings  {{{

set nocompatible          " Enable vim features
set backup                " Enable backup files
set backupdir=~/.vim/tmp/ " Backup to a tmp dir

" Allow backspace to remove indents, newlines and old text
set backspace=indent,eol,start

" Tab options
set expandtab       " Use spaces
set tabstop=4
set softtabstop=4
set shiftwidth=4
set smarttab        " Indent using shiftwidth
set autoindent      " Copy indent from previous line

" Display options
set nowrap          " Do not wrap lines by default
set ruler           " Always show cursor position
set laststatus=2    " Always show the status line
set novisualbell    " Don't flash the screen
set list            " Show non-printing characters by default
set listchars=tab:⇥\ ,trail:·,extends:⋯,precedes:⋯,eol:⏎
set statusline=(%{strlen(&ft)?&ft:'?'},%{&fenc},%{&ff})\ \ %-9.(%l,%c%V%)\ \ %<%P

" Show only spaces, not ugly bars
set fillchars=

" Matching characters
set showmatch       " Show matching brackets
set matchpairs+=<:> " Make < and > match as well
set matchtime=3     " Show matching brackets for only 0.3 seconds

" Buffer options
set autowrite       " Automatically save before commands like :next and :make
set hidden          " Hide buffers when they are abandoned

" Split options
set splitright
set nosplitbelow

if v:version >= 700
    set numberwidth=1     " Keep line numbers small if it's shown
    set completeopt-=menu " Get rid of the ugly menu
endif

filetype plugin indent on " Enable filetype detection
syntax on                 " Syntax highliting

if has('folding')
    set foldenable         " Enable code folding
    set foldmethod=marker  " Fold on marker
    set foldmarker={{{,}}} " Keep foldmarkers default
    set foldopen-=search   " Do not open folds when searching
    set foldopen-=undo     " Do not open folds when undoing changes
    set foldlevel=999      " High default so folds are shown to start
    set foldcolumn=0       " Don't show a fold column
endif

if has('gui')
    set guioptions=
    set guifont=Monaco
endif

if has('persistent_undo')
    set undofile            " Enable persistent undo
    set undodir=~/.vim/tmp/ " Store undofiles in a tmp dir
endif

" Open help in a vsplit rather than a split
command! -nargs=? -complete=help Help :vertical help <args>
cabbrev h h<C-\>esubstitute(getcmdline(), '^h\>', 'Help', '')<CR>

if filereadable(expand('~/.vimrc_local'))
    execute 'source ' . expand('~/.vimrc_local')
endif
"}}}

" Color Settings "{{{
set background=dark

" Set 256 color colorscheme if we can
if $TERM =~ "256color" || has('gui_running')
    colorscheme xoria256-mod
else
    colorscheme darkdot
endif
"}}}

" Auto Commands "{{{
if has('autocmd')
    " Set mutt settings
    autocmd BufRead,BufNewFile /tmp/mutt-* set filetype=mail | set textwidth=72 | set spell | set wrap

    " Automatically add CREATED date and update MODIFIED date
    if v:version >= 700
        autocmd BufNewFile * call Created()
        autocmd BufWrite * call LastModified()
    endif

    " Explicitly set filetype on certain files
    autocmd BufRead,BufNewFile *.jinja set filetype=htmljinja

    " Restore cursor position
    autocmd BufReadPost * call RestoreCursorPos()
    autocmd BufWinEnter * call OpenFoldOnRestore()
endif
"}}}

" Key Maps  "{{{
" Unmap annoying keys
nnoremap q: <Nop>
nnoremap q/ <Nop>
nnoremap q? <Nop>

" Alternate escape
inoremap jj <Esc>
cnoremap jj <Esc>

" Select pasted text
nnoremap gV `[v`]

" Lazy pair expansion
inoremap {<CR> {<CR>}<C-o>O<TAB>
inoremap [<CR> [<CR>]<C-o>O<TAB>
inoremap (<CR> (<CR>)<C-o>O<TAB>

" Give me the option to quickly move in insert mode if need be.
inoremap <C-a> <C-o>0
inoremap <C-e> <C-o>$
inoremap <C-b> <C-o>h
inoremap <C-n> <C-o><C-n>
inoremap <C-p> <C-o><C-p>
inoremap <C-f> <C-o>l

" Change leader to something easier to reach
let mapleader=','

" Comment conveniently
vmap <Leader>c :call CommentLines()<CR>

" Quickly save a file as root
cabbrev w!! w !sudo tee % > /dev/null<CR>:e!<CR><CR>

" Modify display
nmap <Leader>L :setlocal invlist<CR>
nmap <Leader>N :setlocal invnumber<CR>
nmap <Leader>W :match todo /\%80v.\+/<CR>

" Buffer Mappings
if v:version >= 700
    for i in range(1,9,1)
        execute "silent! noremap <Leader>".i." :buffer! ".i."<CR>"
        execute "silent! noremap <Leader>s".i." :sbuffer! ".i."<CR>"
        execute "silent! noremap <Leader>v".i." :vertical sbuffer! ".i."<CR>"
    endfor
endif
"}}}

" Mouse Settings "{{{
if has('mouse')
    set mouse=a            " Enable mouse usage (all modes) in terminals
    set ttymouse=xterm2    " Make mouse and putty work together

    map <M-Esc>[62~ <MouseDown>
    map! <M-Esc>[62~ <MouseDown>
    map <M-Esc>[63~ <MouseUp>
    map! <M-Esc>[63~ <MouseUp>
    map <M-Esc>[64~ <S-MouseDown>
    map! <M-Esc>[64~ <S-MouseDown>
    map <M-Esc>[65~ <S-MouseUp>
    map! <M-Esc>[65~ <S-MouseUp>
endif
"}}}

" Functions "{{{
" Auto update create date
if v:version >= 700
    function! Created()
        normal msHmS
        let n = min([20, line("$")])
        execute '1,' . n . 's#^\(.\{,10}CREATED:  \).*#\1' . strftime('%Y-%m-%d %H:%M') . '#e'
        normal `Szt`s
        call LastModified()
    endfunction

    " Auto update last modified date
    function! LastModified()
        if &modified
            normal msHmS
            let n = min([20, line("$")])
            execute '1,' . n . 's#^\(.\{,10}MODIFIED: \).*#\1' . strftime('%Y-%m-%d %H:%M') . '#e'
            normal `Szt`s
        endif
    endfunction
endif

" Restore cursor position
function! RestoreCursorPos()
    if expand("<afile>:p:h") !=? $TEMP
        if line("'\"") > 1 && line("'\"") <= line("$")
            let line_num = line("'\"")
            let b:doopenfold = 1
            if (foldlevel(line_num) > foldlevel(line_num - 1))
                let line_num = line_num - 1
                let b:doopenfold = 2
            endif
            execute line_num
        endif
    endif
endfunction

" Open the fold if restoring cursor position
function! OpenFoldOnRestore()
    if exists("b:doopenfold")
        execute "normal zv"
        if(b:doopenfold > 1)
            execute "+".1
        endif
        unlet b:doopenfold
    endif
endfunction

"}}}

" Plugin Specific {{{

" Vim 7 and above {{{
if v:version >= 700
    " NERD Commenter
    let NERDCreateDefaultMappings = 0
    let NERDCommentWholeLinesInVMode = 1
    let NERDSpaceDelims = 1
    map <Leader>c <plug>NERDCommenterToggle

    " SnipMate
    let g:snips_author = 'Randy Morris'
    let g:snips_email = 'randy@rsontech.net'
    let g:snips_dir = '~/.vim/snippets/'

    " Super Tab
    let g:SuperTabDefaultCompletionType = "context"
    let g:SuperTabMidWordCompletion = 0

    " Bufstat
    highlight BufferNC ctermfg=248 ctermbg=239
    highlight link Buffer StatusLine
    let g:bufstat_active_hl_group = 'Buffer'
    let g:bufstat_inactive_hl_group = 'BufferNC'
    let g:bufstat_debug = 1
endif
" }}}

" Vim 7.3 and above {{{
if v:version >= 703
    " Gundo
    nmap <Leader>U :GundoToggle<CR>
    let g:gundo_preview_bottom = 1
    let g:gundo_preview_height = 10
    let g:gundo_width = 30
endif
"}}}

"}}}

" vim:foldlevel=0:foldmethod=marker
