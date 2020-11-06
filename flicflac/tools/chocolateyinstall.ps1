$ErrorActionPreference = 'Stop'
$packageName  = 'flicflac' 

Install-ChocolateyShortcut -shortcutFilePath "$ENV:Public\Desktop\FlicFlac.lnk" -targetPath "$ENV:ChocolateyInstall\lib\flicflac\tools\FlicFlac.exe"
