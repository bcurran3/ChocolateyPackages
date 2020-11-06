$ErrorActionPreference = 'Stop'
$packageName= 'hardware-identify.portable'

Remove-Item "$ENV:Public\Desktop\Hardware Identify.lnk" -Force -ErrorAction SilentlyContinue
Remove-Item "$ENV:ProgramData\Microsoft\Windows\Start Menu\Programs\Hardware Identify.lnk" -Force -ErrorAction SilentlyContinue
