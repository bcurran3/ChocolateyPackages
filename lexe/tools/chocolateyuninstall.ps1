$packageName = 'lexe'

remove-item "$env:Public\Desktop\LExE.lnk" -Force -ErrorAction 'SilentlyContinue'
remove-item "$env:ProgramData\Microsoft\Windows\Start Menu\Programs\LExE.lnk" -Force -ErrorAction 'SilentlyContinue'