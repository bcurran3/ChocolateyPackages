$ErrorActionPreference = 'Stop'
$packageName    = 'wsl-sles'

wslconfig /unregister SLES
wslconfig /list

Uninstall-BinFile -Name SLES