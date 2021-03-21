" MIT LICENSE Copyright (c) 2020-2021 Kareem Ahmad.

" ------------------------------------------------------------------
" Security
" ------------------------------------------------------------------

:set modelines=0
:set nomodeline

" ------------------------------------------------------------------
" Disable Annoying Beeps
" ------------------------------------------------------------------

" set belloff=all
hi clear CursorLine

" ------------------------------------------------------------------
" Themes and UI
" ------------------------------------------------------------------

" Airline
let g:airline_theme='twofirewatch'
let g:airline#extensions#tabline#formatter = 'unique_tail_improved'
let g:airline_symbols_ascii = 1

" Basic Themes
colorscheme PaperColor
syntax on
set bg=dark
set noshowmode      " hide Vim's default -- Mode --
set guifont=Ubuntu_Mono:h8
set number          " show line numbers
set showmatch       " highlight corresp [{()}]
set cursorline      " highlight current line
filetype indent plugin on  " load filetype-specific indent data
syntax on
if has ("gui_running")
    set guioptions -=m  " hide File Edit Tools ... menu
    set guioptions -=T  " hide open, save, undo, redo, ... toolbar
endif

" ------------------------------------------------------------------
" Behavior
" ------------------------------------------------------------------

" Spacing
set tabstop=4       " visual spaces per tab
set softtabstop=4   " spaces inserted per tab
set shiftwidth=4    " shift with tab = 4
set expandtab       " tabs are spaces

" Searching
set hlsearch        " highlight matches
set incsearch       " search as query entered

" Folding
set foldenable      " enable folding
set foldmethod=indent "fold by indent
set foldlevelstart=10 "open most folds by default
set foldnestmax=10    "10 nested fold maximum
nnoremap <space> za

" Cut-Copy-Paste-Paste
noremap <C-X> "+x 
noremap <C-C> "+y
noremap <C-Q> "+gP
inoremap <C-Q> <C-R>*

" Move by visual line (instead of physical)
"nnoremap j gj
"nnoremap k gk
nnoremap gV `[v`] "I forgot what this does

" Wrapping
set backspace=indent,eol,start " allow backspacing over these special characters
set whichwrap+=<,>,h,l,[,]     " allow wrapping to previous lines <> arrows in norm, [] arrows in insert

" Control Space to leave insert, <leader>Space to clear highlight
inoremap <C-Space> <Esc>
nnoremap <leader><Space> :noh<CR>

" ------------------------------------------------------------------
" Undo
" ------------------------------------------------------------------

" Persistent Undo (you must mkdir ~/.undodir/ for this to work)
set undofile
if has("persistent_undo")
    set undodir=~/.undodir/
    set undofile
endif

" toggle undotree
nnoremap <leader>u :UndotreeToggle<CR>

" set U to redo
nnoremap U <C-R>

" ------------------------------------------------------------------
" GUI Text Scaling with SHIFT {+/_}
" ------------------------------------------------------------------

function! FontSizePlus ()
    let l:gf_size_whole = matchstr(&guifont, '\(:h\)\@<=\d\+$')
    let l:gf_size_whole = l:gf_size_whole + 1
    let l:new_font_size = ':h'.l:gf_size_whole
    let &guifont = substitute(&guifont, ':h\d\+$', l:new_font_size, '')
endfunction
function! FontSizeMinus ()
    let l:gf_size_whole = matchstr(&guifont, '\(:h\)\@<=\d\+$')
    let l:gf_size_whole = l:gf_size_whole - 1
    let l:new_font_size = ':h'.l:gf_size_whole
    let &guifont = substitute(&guifont, ':h\d\+$', l:new_font_size, '')
endfunction

if has("gui_running")
    nnoremap _ :call FontSizeMinus()<CR>
    nnoremap + :call FontSizePlus()<CR>
endif

" ------------------------------------------------------------------
" GUI Text Scaling with SHIFT {+/_}
" ------------------------------------------------------------------

" trim whitespace function
fun! TrimWhitespace()
    let l:save = winsaveview()
    %s/\s\+$//e
    call winrestview(l:save)
endfun

"netrw
let g:netrw_liststyle = 3 " tree style
let g:netrw_browse_split = 3 " 1 open in horiz, 2 open in vert
"                              3 open in tab, 4 open in previous
let g:netrw_winsize = 25  " 25% of screen when :Vexplore or :Hexplore

" ------------------------------------------------------------------
" Basic Autocomplete
" ------------------------------------------------------------------

inoremap {<CR> {<CR>}<C-o>O
inoremap (<CR> (<CR>)<C-o>O
inoremap [<CR> [<CR>]<C-o>O

" ------------------------------------------------------------------
" OS SPECIFIC ADJUSTMENTS
" ------------------------------------------------------------------

if has("win32") || has("win16") "Windows
    set shell=/Windows/System32/WindowsPowerShell/v1.0/powershell.exe

    " assumes you renamed diff.exe to vimdiff.exe
    function MyDiff()
       let opt = '-a --binary '
       if &diffopt =~ 'icase' | let opt = opt . '-i ' | endif
       if &diffopt =~ 'iwhite' | let opt = opt . '-b ' | endif
       let arg1 = v:fname_in
       if arg1 =~ ' ' | let arg1 = '"' . arg1 . '"' | endif
       let arg2 = v:fname_new
       if arg2 =~ ' ' | let arg2 = '"' . arg2 . '"' | endif
       let arg3 = v:fname_out
       if arg3 =~ ' ' | let arg3 = '"' . arg3 . '"' | endif
       if $VIMRUNTIME =~ ' '
         if &sh =~ '\<cmd'
           if empty(&shellxquote)
             let l:shxq_sav = ''
             set shellxquote&
           endif
           let cmd = '"' . $VIMRUNTIME . '\vimdiff"'
         else
           let cmd = substitute($VIMRUNTIME, ' ', '" ', '') . '\vimdiff"'
         endif
       else
         let cmd = $VIMRUNTIME . '\vimdiff'
       endif
       silent execute '!' . cmd . ' ' . opt . arg1 . ' ' . arg2 . ' > ' . arg3
       if exists('l:shxq_sav')
         let &shellxquote=l:shxq_sav
       endif
    endfunction

    set diffexpr=MyDiff()

else "Unix
    let os = substitute(system('uname'), "\n", "", "")
    "if os == "Linux"
    " uname is a shell function on unix systems
endif
