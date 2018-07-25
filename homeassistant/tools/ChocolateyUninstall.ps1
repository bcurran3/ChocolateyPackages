$ErrorActionPreference = 'Stop'
$packageName  = 'homeassistant'
$shortcutName = 'Home Assitant.lnk'

pip3 uninstall homeassistant -y

remove-item "$env:Public\Desktop\$shortcutName" -Force -ErrorAction 'SilentlyContinue'
remove-item "$env:ProgramData\Microsoft\Windows\Start Menu\Programs\$shortcutName" -Force -ErrorAction 'SilentlyContinue'