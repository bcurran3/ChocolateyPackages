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
>>>>>>> 568a289c53f5b67c34d935dde6b9e808d52c1a9b
>>>>>>> 569b2d7294411478d2ee52bfb07a69a9f3a90929
