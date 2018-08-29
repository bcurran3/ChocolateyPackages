$packageName = 'ammyy-admin' 
$checksum    = '7AEAB9459E2A833D56E474A23AB56BC66645A89FF8EF175050D8B0BED74D090E'

Install-ChocolateyShortcut -shortcutFilePath "$env:Public\Desktop\Ammyy Admin.lnk" -targetPath "$env:ChocolateyInstall\lib\$packageName\tools\AA_v3.exe"
Install-ChocolateyShortcut -shortcutFilePath "$env:ProgramData\Microsoft\Windows\Start Menu\Programs\Ammyy Admin.lnk" -targetPath "$env:ChocolateyInstall\lib\$packageName\tools\AA_v3.exe"
