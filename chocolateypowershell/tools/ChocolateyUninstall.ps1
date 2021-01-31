# ChocolateyPowerShell v0.0.2.3 (01-30-2021) Copyleft 2018-2021 by Bill Curran AKA BCURRAN3
$ErrorActionPreference = 'Stop'
$packageName  = 'chocolateypowershell' 
$shortcutName = 'ChocolateyPowerShell.lnk'

Remove-Item "$ENV:Public\Desktop\$shortcutName" -Force -ErrorAction SilentlyContinue
Remove-Item "$ENV:ProgramData\Microsoft\Windows\Start Menu\Programs\Chocolatey\$shortcutName" -Force -ErrorAction SilentlyContinue
Remove-Item "$ENV:ProgramData\Microsoft\Windows\Start Menu\Programs\$shortcutName" -Force -ErrorAction SilentlyContinue
