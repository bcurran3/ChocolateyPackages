$packageName = 'moose.portable'

Uninstall-ChocolateyZipPackage
remove-item "$env:Public\Desktop\Moose.lnk" -Force -ErrorAction 'SilentlyContinue'
remove-item "$env:ProgramData\Microsoft\Windows\Start Menu\Programs\Moose.lnk" -Force -ErrorAction 'SilentlyContinue'

