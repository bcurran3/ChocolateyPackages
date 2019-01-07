$packageName= 'mame' 

remove-item "$ENV:Public\Desktop\MAME.lnk" -Force -ErrorAction SilentlyContinue
remove-item "$ENV:ProgramData\Microsoft\Windows\Start Menu\Programs\MAME.lnk" -Force -ErrorAction SilentlyContinue
