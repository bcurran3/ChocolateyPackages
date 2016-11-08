$packageName= 'harddriveindicator' 

Install-ChocolateyShortcut -shortcutFilePath "$env:Public\Desktop\HardDriveIndicator.lnk" -targetPath "$env:ChocolateyInstall\lib\$packageName\tools\HardDriveIndicator130.exe"
