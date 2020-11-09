# Installation
Clone this repo wherever you like and create (hard) symlinks to relevant files.

## WINDOWS:
```
mklink /H Link Target # hard link to file
mklink /J Link Target # hard link to directory
```

Note: These commands must be run in cmd (powershell does not support `mklink`)

Note: `mklink /H` does not support hard links to files on another drive.

## LINUX:
```
ln Target Link    # hard link to file/directory
ln -s Target Link # soft link to file/directory
```
