" MIT LICENSE Copyright (c) 2020-2021 Kareem Ahmad.

" System Verilog and Latex autocomplete 

" inoremap begin<CR> begin<CR>end<C-o>O

" Auto Close 
" https://regexr.com // =~# are case-sensitive regex
" class name #() ();
function! WriteClosing(text)
    execute "normal! o" . a:text . "\<esc>"
endfunction

function! CloseItem()
    let line = getline(line('.'))
    
    "--------------------------------------
    " SYSTEM VERILOG
    "--------------------------------------
    if (&ft ==? 'v' || &ft ==? 'sv')
    
        " structure: function
        if line =~# '^\s*\(virtual \)\?function.*'
            let name = split(split(line, '(')[0], ' ')[-1]
            call WriteClosing("endfunction : " . name)

        " stucture: begin w/ name
        elseif line =~# '^.*begin\s*:\s\?\w*'
            let name = split(line, ":")[-1]
            call WriteClosing("end : " . name)

        " stucture: begin
        elseif line =~# '^.*begin.*'
            call WriteClosing("end")

        " structures that close w/ name
        elseif line =~# '^\s*\(class\|task\|module\|program\)\([^a-zA-Z0-9]\).*'
            let items = split(line, ' ')
            call WriteClosing("end" . items[0] . " : " . items[1])

        " virtual structures that close w/ name 
        elseif line =~# '^\s*virtual \(class\|task\)\([^a-zA-Z0-9]\).*'
            let items = split(line, ' ')
            call WriteClosing("end" . items[1] . " : " . items[2])
        
        " fork
        elseif line =~# '^.*fork\([^a-zA-Z0-9]\|$\).*'
            call WriteClosing("join")

        " default
        else
            execute "normal! j"
        endif

    "--------------------------------------
    " LATEX
    "--------------------------------------
    elseif (&ft ==? 'tex')

        "\begin{type} on its own line
        if line =~# '^\s*\\begin{.*}'
            let type = split(split(line, 'begin{')[1], '}')[0]
            "execute "normal! o\\end{" . type . "}\<esc>"
            echo type
            call WriteClosing("\\end{" . type . "}")

        else
            execute "normal! j"
        endif

    "--------------------------------------
    " DEFAULT
    "--------------------------------------
    else
        execute "normal! j"

    endif
endfunction

noremap o :call CloseItem()<CR>O
inoremap \<space> <esc>:call CloseItem()<CR>O

" <C-o> let's the next command happen as if normal mode
