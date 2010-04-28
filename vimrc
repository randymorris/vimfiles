" .vimrc - main ViM settings file
"
" Randy Morris (rson451@gmail.com)
"
" CREATED:  2008-08-18 22:31
" MODIFIED: 2010-04-28 08:57

let g:work = 0
if hostname() == 'vudu'
    let g:work = 1
endif

" Simple Settings  {{{

set nocompatible    " Don't be old and stupid
set tabstop=4       " Small tab width
set softtabstop=4   " Backspace fake tabs
set shiftwidth=4    " Match tab width
set smarttab        " Tabs at the beginning of lines, spaces everywhere else
set nowrap          " Do not wrap lines
set ruler           " Always show a ruler
set laststatus=2    " Always show the status line
set novisualbell    " Shut the hell up
set showmatch       " Show matching brackets
set matchpairs+=<:> " Make < and > match as well
set matchtime=3     " Show matching brackets for only 0.3 seconds
set autowrite       " Automatically save before commands like :next and :make
set hidden          " Hide buffers when they are abandoned
set splitright      " Split windows where I expect them
set autoindent      " Copy indent from previous line
set list            " Show non-printing characters by default

" Uber cool status line
set statusline=%=(%{strlen(&ft)?&ft:'?'},%{&fenc},%{&ff})\ \ %-9.(%l,%c%V%)\ \ %<%P

if v:version >= 700
    set numberwidth=1     " Keep number bar small if it's shown 
    set completeopt-=menu " Get rid of the ugly menu
endif

if g:work == 1
    set noexpandtab " Don't tabs at work
else
    set expandtab   " Don't be stupid at home
endif

" Make backspace act normal
set backspace=indent,eol,start

" Make tabs easier to see with set list
set listchars=tab:+-,trail:·,extends:>,precedes:<,

" Show only spaces, not ugly bars
set fillchars=

filetype plugin on " Enable filetype detection
syntax on          " Syntax highliting

if has('folding')
    set foldenable         " Enable code folding
    set foldmethod=marker  " Fold on marker
    set foldopen-=search   " Do not open folds when searching
    set foldopen-=undo     " Do not open folds when undo'ing changes
    set foldlevel=999      " High default so folds are shown to start
    set foldmarker={{{,}}} " Keep foldmarkers default
    set foldcolumn=0       " Don't waste screen space
endif

if has('gui')
    set guioptions=
    set guifont=Monaco:h10
endif

" Open help in a vsplit rather than a split
command! -nargs=? -complete=help Help :vertical help <args>
"}}}

" Color Settings "{{{
set background=dark " Dark backgrounds == win

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

    " Enable template files
    if has('unix')
        autocmd BufNewFile * silent! 0r $HOME/.vim/templates/%:e.tpl 
    elseif has('windows')
        autocmd BufNewFile * silent! 0r $HOME/vimfiles/templates/%:e.tpl 
    endif

    " Automatically add CREATED date and update MODIFIED date
    autocmd BufNewFile * call Created()
    autocmd BufWrite * call LastModified()

    " Explicitly set filetype on certain files
    autocmd BufRead,BufNewFile *.jinja set filetype=htmljinja

    " Set comment characters for common languages
    autocmd FileType python,sh,bash,zsh,ruby,perl,muttrc let StartComment="#" | let EndComment=""
    autocmd FileType html let StartComment="<!--" | let EndComment="-->"
    autocmd FileType php,cpp,javascript let StartComment="//" | let EndComment=""
    autocmd FileType c,css let StartComment="/*" | let EndComment="*/"
    autocmd FileType vim let StartComment="\"" | let EndComment=""
    autocmd FileType ini let StartComment=";" | let EndComment=""

    " Go back where I left off
    autocmd BufReadPost * call RestoreCursorPos()
    autocmd BufWinEnter * call OpenFoldOnRestore()

endif
"}}}

" Key Maps  "{{{
" Unmap annoying keys
nnoremap q: <Nop>
nnoremap q/ <Nop>
nnoremap q? <Nop>

let mapleader=',' " Change leader to something easier to reach

" Comment conveniently
vmap <Leader>c :call CommentLines()<CR>

" Quickly save a file as root
cabbr w!! w !sudo tee % > /dev/null<CR>:e!<CR><CR>

" Modify display
nmap <Leader>L :setlocal invlist<CR>
nmap <Leader>N :setlocal invnumber<CR>
nmap <Leader>T :TlistToggle<CR><C-w><C-w>
nmap <Leader>R :NERDTreeToggle<CR><C-w><C-w>
nmap <Leader>I :NERDTreeToggle<CR><C-w>l:TlistToggle<CR><C-w>h
nmap <Leader>W :match todo /\%80v.\+/<CR>
nmap <Leader>S :setlocal invspell<CR>
nmap <Leader>O :SessionList<CR>

" Buffer Mappings
for i in range(1,9,1)
    exec "silent! noremap <Leader>".i." :b! ".i."<CR>" 
    exec "silent! noremap <Leader>s".i." :sb! ".i."<CR>" 
    exec "silent! noremap <Leader>v".i." :vertical sb! ".i."<CR>" 
endfor

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

" Toggle comments on a visual block
function! CommentLines()
    try
        execute ":s@^".g:StartComment." @\@g"
        execute ":s@ ".g:EndComment."$@@g"
    catch
        execute ":s@^@".g:StartComment." @g"
        execute ":s@$@ ".g:EndComment."@g"
    endtry
endfunction

" Restore my cursor position
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
" Markdown syntax plugin
set runtimepath+=~/.vim/plugin-git/markdown/

" DelimitMate
set runtimepath+=~/.vim/plugin-git/delimitmate/
let g:delimitMate_expand_cr = "\<CR>\<CR>\<UP>\<C-O>$"
let g:delimitMate_autoclose = 0

" Tag List
set runtimepath+=~/.vim/plugin-git/taglist/
let g:Tlist_GainFocus_On_ToggleOpen = 1
let g:Tlist_Show_Menu = 0
let g:Tlist_Sort_Type = 'order'
let g:Tlist_Use_Right_Window = 1
let g:Tlist_Inc_Winwidth = 0
let g:Tlist_Exit_OnlyWindow = 1
let g:Tlist_Enable_Fold_Column = 0

" NERD Tree
set runtimepath+=~/.vim/plugin-git/nerdtree/
let g:NERDTreeChDirMode = 2
let g:NERDTreeHighlightCursorline = 0

" SnipMate
set runtimepath+=~/.vim/plugin-git/snipmate/
set runtimepath+=~/.vim/plugin-git/snipmate/after/
let g:snips_author = 'Randy Morris'
let g:snips_email = 'randy@rsontech.net'
let g:snippets_dir = '/home/randy/.vim/snippets'

" Super Tab
let g:SuperTabDefaultCompletionType = "context"
let g:SuperTabMidWordCompletion = 0

" Buftabs
let g:buftabs_in_statusline = 1
let g:buftabs_only_basename = 1 
let g:buftabs_marker_start = ''
let g:buftabs_marker_end = ''
let g:buftabs_separator = ' '
let g:buftabs_active_highlight_group = "StatusLine"
let g:buftabs_inactive_highlight_group = "InactiveBuf"
highlight InactiveBuf cterm=bold ctermfg=247 ctermbg=239

" vim:foldlevel=0:foldmethod=marker
