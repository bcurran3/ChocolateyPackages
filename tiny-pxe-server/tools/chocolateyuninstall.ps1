$ErrorActionPreference = 'Stop'
$packageName  = 'tiny-pxe-server' 
$shortcutName = 'TinyPXE Server.lnk'

Remove-Item "$ENV:Public\Desktop\$shortcutName" -Force -ErrorAction SilentlyContinue
Remove-Item "$ENV:ProgramData\Microsoft\Windows\Start Menu\Programs\$shortcutName" -Force -ErrorAction SilentlyContinue
