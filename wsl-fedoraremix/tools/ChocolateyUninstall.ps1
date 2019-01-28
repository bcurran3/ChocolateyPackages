<<<<<<< HEAD
$ErrorActionPreference = 'Stop'
$packageName = 'wsl-fedoraremix'
$shortcutName = 'Fedora Remix.lnk'

wslconfig /unregister fedoraremix
wslconfig /list
Uninstall-BinFile fedoraremix
Remove-Item "$ENV:Public\Desktop\$shortcutName" -Force -ErrorAction SilentlyContinue
Remove-Item "$ENV:ProgramData\Microsoft\Windows\Start Menu\Programs\$shortcutName" -Force -ErrorAction SilentlyContinue
=======
$ErrorActionPreference = 'Stop'
$packageName = 'wsl-fedoraremix'
$shortcutName = 'Fedora Remix.lnk'

wslconfig /unregister fedoraremix
wslconfig /list
Uninstall-BinFile fedoraremix
Remove-Item "$ENV:Public\Desktop\$shortcutName" -Force -ErrorAction SilentlyContinue
Remove-Item "$ENV:ProgramData\Microsoft\Windows\Start Menu\Programs\$shortcutName" -Force -ErrorAction SilentlyContinue
>>>>>>> 569b2d7294411478d2ee52bfb07a69a9f3a90929
