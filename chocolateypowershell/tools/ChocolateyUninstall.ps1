# ChocolateyPowerShell v0.0.2.2 (09-18-2020) Copyleft 2018-2020 by Bill Curran AKA BCURRAN3
$ErrorActionPreference = 'Stop'
$packageName  = 'chocolateypowershell' 
$shortcutName = 'ChocolateyPowerShell.lnk'

remove-item "$ENV:Public\Desktop\$shortcutName" -Force -ErrorAction SilentlyContinue
remove-item "$ENV:ProgramData\Microsoft\Windows\Start Menu\Programs\Chocolatey\$shortcutName" -Force -ErrorAction SilentlyContinue
remove-item "$ENV:ProgramData\Microsoft\Windows\Start Menu\Programs\$shortcutName" -Force -ErrorAction SilentlyContinue
