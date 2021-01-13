function Search-KAGrepR {

    param (
        [Parameter(Mandatory=$true)] [string]$String,
        [Parameter(Mandatory=$true)] [string]$FileType
    )

    Get-ChildItem -Recurse $FileType | Select-String $String -CaseSensitive
}

function Search-KAGrepRI {

    param (
        [Parameter(Mandatory=$true)] [string]$String,
        [Parameter(Mandatory=$true)] [string]$FileType
    )

    Get-ChildItem -Recurse $FileType | Select-String $String
}
