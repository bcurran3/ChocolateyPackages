$packageName= 'namebench' 

Install-ChocolateyShortcut -shortcutFilePath "$env:Public\Desktop\namebench.lnk" -targetPath "$env:ChocolateyInstall\lib\namebench\tools\namebench-1.3.1-Windows.exe"
Install-ChocolateyShortcut -shortcutFilePath "$env:ProgramData\Microsoft\Windows\Start Menu\Programs\namebench.lnk" -targetPath "$env:ChocolateyInstall\lib\$packageName\tools\namebench-1.3.1-Windows.exe"