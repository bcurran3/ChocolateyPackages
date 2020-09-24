$ErrorActionPreference = 'Stop'
$packageName    = 'wsl-sles'

wslconfig /unregister SLES-12
wslconfig /list
