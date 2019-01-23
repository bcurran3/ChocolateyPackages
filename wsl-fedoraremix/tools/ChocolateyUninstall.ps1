$ErrorActionPreference = 'Stop'
$packageName = 'wsl-fedoraremix'
$shortcutName = 'Fedora Remix.lnk'

wslconfig /unregister fedoraremix
wslconfig /list
Uninstall-BinFile fedoraremix
Remove-Item "$ENV:Public\Desktop\$shortcutName" -Force -ErrorAction SilentlyContinue
Remove-Item "$ENV:ProgramData\Microsoft\Windows\Start Menu\Programs\$shortcutName" -Force -ErrorAction SilentlyContinue
