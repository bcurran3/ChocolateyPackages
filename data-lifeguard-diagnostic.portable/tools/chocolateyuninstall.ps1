$packageName = 'data-lifeguard-diagnostic.portable'

Uninstall-ChocolateyZipPackage
remove-item "$env:Public\Desktop\Data Lifeguard Diagnostic for Windows.lnk" -Force -ErrorAction 'SilentlyContinue'
remove-item "$env:ProgramData\Microsoft\Windows\Start Menu\Programs\Data Lifeguard Diagnostic for Windows.lnk" -Force -ErrorAction 'SilentlyContinue'

