$ErrorActionPreference = 'Stop'
$packageName    = 'wsl-kalilinux'

wslconfig /unregister MyDistribution
wslconfig /list