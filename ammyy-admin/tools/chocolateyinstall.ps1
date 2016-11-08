$packageName= 'ammyy-admin' 

Install-ChocolateyShortcut -shortcutFilePath "$env:Public\Desktop\Ammyy Admin.lnk" -targetPath "$env:ChocolateyInstall\lib\$packageName\tools\AA_v3.exe"
Install-ChocolateyShortcut -shortcutFilePath "$env:ProgramData\Microsoft\Windows\Start Menu\Programs\Ammyy Admin.lnk" -targetPath "$env:ChocolateyInstall\lib\$packageName\tools\AA_v3.exe"
