$ErrorActionPreference = 'Stop'
$packageName    = 'wsl-kalilinux'

wslconfig /unregister SLES-12
wslconfig /list

Uninstall-BinFile -Name SLES-12