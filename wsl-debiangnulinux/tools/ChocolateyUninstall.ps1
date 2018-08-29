$ErrorActionPreference = 'Stop'
$packageName    = 'wsl-debiangnulinux'

wslconfig /unregister SLES-12
wslconfig /list

Uninstall-BinFile -Name SLES-12