scriptencoding utf-8

if has("win32") || has("win16") "Windows
    set shell=/Windows/System32/WindowsPowerShell/v1.0/powershell.exe
    let s:os = "Windows"
else "Unix
    let s:os = substitute(system('uname'), "\n", "", "")
    "if os == "Linux"
    " uname is a shell function on unix systems
endif

function! search#grepr(string, ending)
    if s:os == "Windows"
        "let ex = "!\"Get-ChildItem -Recurse " . a:ending . " | Select-String " . a:string . "\""
        let ex = "!Search-KAGrepR -String '" . a:string . "' -FileType '" . a:ending . "' | gvim - "
        execute ex
    else
        let ex = "!grep '" . a:string . "' -n -H -r " . a:ending
        execute ex
    endif
endfunction

function! search#grepri(string, ending)
    if s:os == "Windows"
        "let ex = "!\"Get-ChildItem -Recurse " . a:ending . " | Select-String " . a:string . "\""
        let ex = "!Search-KAGrepRI -String '" . a:string . "' -FileType '" . a:ending . "' | gvim - "
        execute ex
    else
        let ex = "!grep '" . a:string . "' -n -H -r " . a:ending
        execute ex
    endif
endfunction

command! -nargs=* Grep call search#grepr(<f-args>)
command! -nargs=* Grepi call search#grepr(<f-args>)

