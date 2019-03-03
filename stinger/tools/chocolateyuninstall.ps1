$ErrorActionPreference = 'Stop'
$packageName = 'stinger'

Uninstall-BinFile stinger
Remove-Item "$env:Public\Desktop\McAfee Stinger.lnk" -Force -ErrorAction SilentlyContinue
Remove-Item "$env:ProgramData\Microsoft\Windows\Start Menu\Programs\McAfee Stinger.lnk" -Force -ErrorAction SilentlyContinue
