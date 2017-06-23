$packageName = 'pytivo-desktop'

remove-item "$env:Public\Desktop\pyTivo.lnk" -Force -ErrorAction 'SilentlyContinue'
remove-item "$env:ProgramData\Microsoft\Windows\Start Menu\Programs\pyTivo.lnk" -Force -ErrorAction 'SilentlyContinue'




