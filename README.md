# Introduction
This repo is just a collection of useful defaults I like keep handy whether I'm working on a windows or unix machine. It includes vim defaults, some powershell tools, and a userrc. Feel free to tinker with it if you like. I did not create and do not own the vim colorschemes, each scheme has its license information in the header. See the readme in the .vim directory for details.

# Installation
Clone this repo wherever you like and create (hard) symlinks to relevant files.

## WINDOWS:
Clone this repo on the same drive as your home directory. 

### Symbolic Links
```
mklink /H Link Target # hard link to file
mklink /J Link Target # hard link to directory
```
Note: These commands must be run in cmd (powershell does not support `mklink`)  
Note: `mklink /H` does not support hard links to files on another drive.  

### VIM Setup
Create links `vimfiles` -> `.vim` and `_vimrc` -> `.vimrc` files in the cloned repo.  
To enable Grep command in vim, powershell (x86) needs ExecutionPolicy to be at least RemoteSigned. Note that `powershell` and `powershell (x86)` have different values for this property.
``` 
Get-ExecutionPolicy 
Set-ExecutionPolicy {value}
```

### Powershell Module Setup
Create links from each module directory in `PowerShellModules/*` into `%USERPROFILE%/Documents/WindowsPowerShell/Modules/*`  
[Microsoft documentation](https://docs.microsoft.com/en-us/powershell/scripting/learn/ps101/09-functions?view=powershell-7.1)

## LINUX:
### Symbolic Links
```
ln Target Link    # hard link to file/directory
ln -s Target Link # soft link to file/directory
```

### Setup
Create symbolic links for `.vim`, `.vimrc`, `.userrc` in your home `~/` directory.
