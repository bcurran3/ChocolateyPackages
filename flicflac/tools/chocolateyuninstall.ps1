$ErrorActionPreference = 'Stop'
$packageName = 'flicflac'

Remove-Item "$ENV:Public\Desktop\FlicFlac.lnk" -Force -ErrorAction SilentlyContinue
