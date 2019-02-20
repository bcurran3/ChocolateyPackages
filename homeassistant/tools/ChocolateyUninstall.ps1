$ErrorActionPreference = 'Stop'
$packageName  = 'homeassistant'
$shortcutName = 'Home Assitant.lnk'

pip3 uninstall homeassistant -y

Remove-Item "$env:Public\Desktop\$shortcutName" -Force -ErrorAction SilentlyContinue
Remove-Item "$env:ProgramData\Microsoft\Windows\Start Menu\Programs\$shortcutName" -Force -ErrorAction SilentlyContinue
