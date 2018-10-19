$ErrorActionPreference = 'Stop'
$packageName    = 'wsl-archlinux'

wslconfig /unregister Arch_Linux
wslconfig /list
Uninstall-BinFile arch
