"Author: Nachum Kanovsky
"Email: nkanovsky@yahoo.com
"Version: 1.9
if exists("b:did_ftplugin")
	finish
endif

let b:did_ftplugin = 1

" Undo the plugin effect
"let b:undo_ftplugin = "unlet b:match_ignorecase b:match_words"

" Let the matchit plugin know what items can be matched.
if exists("loaded_matchit")
  let b:match_ignorecase=0
  let b:match_words=
        \ '\<begin\>:\<end\>,' .
        \ '\<if\>:\<else\>,' .
        \ '\<module\>:\<endmodule\>,' .
        \ '\<class\>:\<endclass\>,' .
        \ '\<program\>:\<endprogram\>,' .
        \ '\<clocking\>:\<endclocking\>,' .
        \ '\<property\>:\<endproperty\>,' .
        \ '\<sequence\>:\<endsequence\>,' .
        \ '\<package\>:\<endpackage\>,' .
        \ '\<covergroup\>:\<endgroup\>,' .
        \ '\<primitive\>:\<endprimitive\>,' .
        \ '\<specify\>:\<endspecify\>,' .
        \ '\<generate\>:\<endgenerate\>,' .
        \ '\<interface\>:\<endinterface\>,' .
        \ '\<function\>:\<endfunction\>,' .
        \ '\<task\>:\<endtask\>,' .
        \ '\<case\>\|\<casex\>\|\<casez\>:\<endcase\>,' .
        \ '\<fork\>:\<join\>\|\<join_any\>\|\<join_none\>,' .
        \ '`ifdef\>:`else\>:`endif\>,' .
        \ '\<generate\>:\<endgenerate\>'
endif


"Kareem Stuff
" System Verilog-specific overrides

" inoremap begin<CR> begin<CR>end<C-o>O


" Auto Close 
" https://regexr.com // =~# are case-sensitive regex
" class name #() ();
function! CloseItem()
    let line = getline(line('.'))
    
    " structure: function
    if line =~# '^\s*\(virtual \)\?function.*'
        let name = split(split(line, '(')[0], ' ')[-1]
        execute "normal! oendfunction : " . name . "\<esc>"

    " stucture: begin w/ name
    elseif line =~# '^.*begin\s*:\s\?\w*'
        let name = split(line, ":")[-1]
        execute "normal! oend : " . name . "\<esc>"

    " stucture: begin
    elseif line =~# '^.*begin.*'
        execute "normal! oend \<esc>"

    " structures that close w/ name
    elseif line =~# '^\s*\(class\|task\|module\|program\)\([^a-zA-Z0-9]\).*'
        let items = split(line, ' ')
        let type = items[0]
        let name = items[1]
        execute "normal! oend" . type . " : " . name . "\<esc>"

    " virtual structures that close w/ name 
    elseif line =~# '^\s*virtual \(class\|task\)\([^a-zA-Z0-9]\).*'
        let items = split(line, ' ')
        let type = items[1]
        let name = items[2]
        execute "normal! oend" . type . " : " . name . "\<esc>"
    
    " fork
    elseif line =~# '^.*fork\([^a-zA-Z0-9]\|$\).*'
        execute "normal! \<esc>ojoin\<esc>"

    " default
    else
        execute "normal! j"

    endif
endfunction

noremap o :call CloseItem()<CR>O
inoremap \<space> <esc>:call CloseItem()<CR>O

" <C-o> let's the next command happen as if normal mode
