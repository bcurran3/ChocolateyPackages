$ErrorActionPreference = 'Stop'
$packageName = 'wsl-fedoraremix'

wslconfig /unregister fedoraremix
wslconfig /list
Uninstall-BinFile fedoraremix
