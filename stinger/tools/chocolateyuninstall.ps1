$packageName = 'stinger'

Uninstall-BinFile stinger
remove-item "$env:Public\Desktop\McAfee Stinger.lnk" -Force -ErrorAction 'SilentlyContinue'
remove-item "$env:ProgramData\Microsoft\Windows\Start Menu\Programs\McAfee Stinger.lnk" -Force -ErrorAction 'SilentlyContinue'

