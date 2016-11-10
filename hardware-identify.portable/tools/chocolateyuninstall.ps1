$packageName= 'hardware-identify.portable'

remove-item "$env:Public\Desktop\Hardware Identify.lnk" -Force -ErrorAction 'SilentlyContinue'
remove-item "$env:ProgramData\Microsoft\Windows\Start Menu\Programs\Hardware Identify.lnk" -Force -ErrorAction 'SilentlyContinue'
