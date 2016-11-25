$packageName = 'disk-wipe'

remove-item "$env:Public\Desktop\DiskWipe.lnk" -Force -ErrorAction 'SilentlyContinue'
remove-item "$env:ProgramData\Microsoft\Windows\Start Menu\Programs\DiskWipe.lnk" -Force -ErrorAction 'SilentlyContinue'

