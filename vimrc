" .vimrc - main ViM settings file
"
" Randy Morris (rson451@gmail.com)
"
" CREATED:  2008-08-18 22:31
" MODIFIED: 2010-10-26 13:44

" Setup Pathogen "{{{
try
    " this throws an E107 error if not on vim 7,
    " even with a version trap around it.  just 
    " catch it and load vim 6 plugins later.
    call pathogen#runtime_append_all_bundles('plugin-git')
    filetype off
catch /^Vim\%((\a\+)\)\=:E107/
    " pass
endtry
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
set listchars=tab:⇥\ ,trail:·,extends:⋯,precedes:⋯,
set statusline=%=(%{strlen(&ft)?&ft:'?'},%{&fenc},%{&ff})\ \ %-9.(%l,%c%V%)\ \ %<%P
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

filetype plugin on " Enable filetype detection
syntax on          " Syntax highliting

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
cabbrev h h<C-\>esubstitute(getcmdline(), '^h\>', 'Help', '')

if filereadable(expand('~/.vimrc_local'))
    exec 'source ' . expand('~/.vimrc_local')
endif
"}}}

" Color Settings "{{{
set background=dark

" Set 256 color colorscheme if we can
if $TERM =~ "256color" || has('gui_running')
    colorscheme xoria256
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
inoremap {}<CR> {<CR>}<C-o>O<TAB>

let mapleader=',' " Change leader to something easier to reach

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
        execute "silent! noremap <Esc>".i." :b! ".i."<CR>"
        execute "silent! noremap <Esc>s".i." :sb! ".i."<CR>"
        execute "silent! noremap <Esc>v".i." :vertical sb! ".i."<CR>"
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

" Vim 6 and above {{{
if v:version >= 600
    " Taglist
    if v:version < 700
        " Pathogen doesn't work with vim 6 but Taglist does
        set rtp+=~/.vim/plugin-git/taglist
    endif

    let g:Tlist_GainFocus_On_ToggleOpen = 1
    let g:Tlist_Show_Menu = 0
    let g:Tlist_Sort_Type = 'order'
    let g:Tlist_Use_Right_Window = 1
    let g:Tlist_Inc_Winwidth = 0
    let g:Tlist_Exit_OnlyWindow = 1
    let g:Tlist_Enable_Fold_Column = 0
    nmap <Leader>T :TlistToggle<CR><C-w><C-w>
endif
" }}}

" Vim 7 and above {{{
if v:version >= 700
    " NERD Tree
    let g:NERDTreeChDirMode = 2
    let g:NERDTreeHighlightCursorline = 0
    nmap <Leader>R :NERDTreeToggle<CR><C-w><C-w>

    " NERD Commenter
    let NERDCreateDefaultMappings = 0
    let NERDCommentWholeLinesInVMode = 1
    let NERDSpaceDelims = 1
    map <Leader>c <plug>NERDCommenterToggle

    " SnipMate
    let g:snips_author = 'Randy Morris'
    let g:snips_email = 'randy@rsontech.net'

    " Super Tab
    let g:SuperTabDefaultCompletionType = "context"
    let g:SuperTabMidWordCompletion = 0

    " Conque
    if has('python')
        autocmd filetype conque_term setlocal nolist
        let g:ConqueTerm_CWInsert = 1

        nmap <Leader>S :ConqueTerm zsh<CR>
        nmap <Leader>s :ConqueTermSplit zsh<CR>
        nmap <Leader>v :ConqueTermVSplit zsh<CR>
    endif

    " DelimitMate
    let g:delimitMate_expand_cr = 1
    let g:delimitMate_autoclose = 0
endif
" }}}

" Vim 7.3 and above {{{
if v:version >= 703
    " Gundo
    nmap <Leader>U :GundoToggle<CR>
endif
"}}}

"}}}

" vim:foldlevel=0:foldmethod=marker
