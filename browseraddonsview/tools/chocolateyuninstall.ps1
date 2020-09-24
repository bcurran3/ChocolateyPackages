$ErrorActionPreference = 'Stop'
$packageName  = 'browseraddonsview' 
$shortcutName = 'BrowserAddonsView.lnk'

Remove-Item "$ENV:Public\Desktop\$shortcutName" -Force -ErrorAction SilentlyContinue
Remove-Item "$ENV:ProgramData\Microsoft\Windows\Start Menu\Programs\$shortcutName" -Force -ErrorAction SilentlyContinue
