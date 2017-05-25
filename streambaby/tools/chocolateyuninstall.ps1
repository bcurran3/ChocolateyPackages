$packageName = 'streambaby'

remove-item "$env:Public\Desktop\$packageName.lnk" -Force -ErrorAction 'SilentlyContinue'
remove-item "$env:ProgramData\Microsoft\Windows\Start Menu\Programs\$packageName.lnk" -Force -ErrorAction 'SilentlyContinue'

