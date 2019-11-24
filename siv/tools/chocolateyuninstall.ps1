$ErrorActionPreference = 'Stop'
$packageName = 'siv' 

Remove-Item "$env:Public\Desktop\SIV.lnk" -Force -ErrorAction SilentlyContinue
Remove-Item "$env:ProgramData\Microsoft\Windows\Start Menu\Programs\SIV.lnk" -Force -ErrorAction SilentlyContinue
