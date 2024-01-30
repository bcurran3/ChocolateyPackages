$ErrorActionPreference = 'Stop'
$packageName = 'flicflac'

Remove-Item "$ENV:Public\Desktop\FlicFlac.lnk" -Force -ErrorAction SilentlyContinue
Remove-Item "$ENV:ProgramData\Microsoft\Windows\Start Menu\Programs\FlicFlac.lnk" -Force -ErrorAction SilentlyContinue
