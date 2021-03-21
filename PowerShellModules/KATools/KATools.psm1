# Recursive case-sensitive search (mimics grep -r on unix)
function Search-KAGrepR {

    param (
        [Parameter(Mandatory=$true)] [string]$String,
        [Parameter(Mandatory=$true)] [string]$FileType
    )

    Get-ChildItem -Recurse $FileType | Select-String $String -CaseSensitive
}

# Recursive case-insensitive search (mimics grep -r on unix)
function Search-KAGrepRI {

    param (
        [Parameter(Mandatory=$true)] [string]$String,
        [Parameter(Mandatory=$true)] [string]$FileType
    )

    Get-ChildItem -Recurse $FileType | Select-String $String
}

# Starts a windows-store app
# The PackageFamilyName can be found by searching the contents of get-appxpackage
function Start-StoreApp {

    param (
        [Parameter(Mandatory=$true)] [string]$PackageFamilyName
    )

    explorer.exe shell:appsFolder\$PackageFamilyName!App
}

# Starts Terminal Preview
function Start-Terminal {
    Start-StoreApp Microsoft.WindowsTerminalPreview_8wekyb3d8bbwe
}

# Get-ChildItem $Path | Where{$_.Name -Match "<RegEx Pattern>"} | Remove-Item
