# Installation
Clone this repo wherever you like and create (hard) symlinks to relevant files.

## WINDOWS:
Clone this repo on the same drive as your home directory (typically C:)
In your home directory:
```
cd ~
git clone https://github.com/kareemalgalaly/config.git
mklink /H _vimrc   config/.vimrc    # replace config with path to config if you cloned it somewhere else
mklink /J vimfiles config/.vim      # ^
```

### Symbolic Links
```
mklink /H Link Target # hard link to file
mklink /J Link Target # hard link to directory
```

Note: These commands must be run in cmd (powershell does not support `mklink`)

Note: `mklink /H` does not support hard links to files on another drive.

## LINUX:
### Symbolic Links
```
ln Target Link    # hard link to file/directory
ln -s Target Link # soft link to file/directory
```
