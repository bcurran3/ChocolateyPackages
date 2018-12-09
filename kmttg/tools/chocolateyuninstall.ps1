$packageName = 'kmttg'

remove-item "$env:Public\Desktop\kmttg.lnk" -Force -ErrorAction SilentlyContinue
remove-item "$env:ProgramData\Microsoft\Windows\Start Menu\Programs\kmttg.lnk" -Force -ErrorAction SilentlyContinue
