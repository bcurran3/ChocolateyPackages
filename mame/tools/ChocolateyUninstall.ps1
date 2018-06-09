$packageName= 'mame' 

remove-item "$env:Public\Desktop\MAME.lnk" -Force -ErrorAction 'SilentlyContinue'
remove-item "$env:ProgramData\Microsoft\Windows\Start Menu\Programs\MAME.lnk" -Force -ErrorAction 'SilentlyContinue'

