" Reference
" https://dougblack.io/words/a-good-vimrc.html

" cmd prompt : prompt /? for info
" setx PROMPT $g$s       for set default

"security
:set modelines=0
:set nomodeline

"colorscheme deus
let g:airline_theme='twofirewatch'
"let g:airline#extensions#tabline#enabled = 1
"let g:airline#extensions#tabline#left_sep=' '
"let g:airline#extensions#tabline#left_alt_sep='>'
let g:airline#extensions#tabline#formatter = 'unique_tail_improved'
let g:airline_symbols_ascii = 1
"if !exists('g:airline_symbols')
"    let g:airline_symbols = {}
"endif
"let g:airline_left_sep='▶'
"set encoding=utf-8

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
"set guioptions -=m  " hide File Edit Tools ... menu
"set guioptions -=T  " hide open, save, undo, redo, ... toolbar

" Spacing
set tabstop=4       " visual spaces per tab
set softtabstop=4   " spaces inserted per tab
set shiftwidth=4    " shift with tab = 4
set expandtab       " tabs are spaces

" Searching
set hlsearch        " highlight matches
set incsearch       " search as query entered
"nnoremap <esc> :noh<CR> " causes weird issues (enter in REPLACE)

" Folding (collapse code blocks)
set foldenable      " enable folding
set foldmethod=indent "fold by indent
set foldlevelstart=10 "open most folds by default
set foldnestmax=10    "10 nested fold maximum
nnoremap <space> za

" Persistent Undo
set undofile   " Maintain undo history between sessions
if has("persistent_undo")
    set undodir=~/.undodir/
    set undofile
endif
let mapleader="\\"  "set leader to be the comma (not backslash)
" toggle gundo (display undo tree)
nnoremap <leader>u :UndotreeToggle<CR>
" set U to redo
nnoremap U <C-R>


" Behavior
set backspace=indent,eol,start " allow backspacing over these special characters
set whichwrap+=<,>,h,l,[,]     " allow wrapping to previous lines <> arrows in norm, [] arrows in insert
" Cut-Copy-Paste
noremap <C-X> "+x
noremap <C-C> "+y
noremap <C-Q> "+gP
inoremap <C-Q> <C-R>*
" move by visual line (instead of physical)
"nnoremap j gj
"nnoremap k gk
nnoremap gV `[v`]

" + / - grow and shrink view
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

" Control Space to enter or leave insert
inoremap <C-Space> <Esc>
nnoremap <leader><Space> :noh<CR>

" set belloff=all
hi clear CursorLine

inoremap {<CR> {<CR>}<C-o>O
inoremap (<CR> (<CR>)<C-o>O
inoremap [<CR> [<CR>]<C-o>O
