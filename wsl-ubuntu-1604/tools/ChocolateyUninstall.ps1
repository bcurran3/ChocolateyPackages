$ErrorActionPreference = 'Stop'
$packageName    = 'wsl-ubuntu-1604'

wslconfig /unregister Ubuntu-16.04
wslconfig /list
