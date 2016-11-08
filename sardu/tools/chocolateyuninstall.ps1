$packageName = 'sardu'

#Uninstall-ChocolateyZipPackage
remove-item "$env:Public\Desktop\SARDU.lnk" -Force -ErrorAction 'SilentlyContinue'
remove-item "$env:ProgramData\Microsoft\Windows\Start Menu\Programs\SARDU.lnk" -Force -ErrorAction 'SilentlyContinue'

