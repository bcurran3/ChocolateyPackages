$packageName = 'namebench'

remove-item "$env:Public\Desktop\namebench.lnk" -Force -ErrorAction 'SilentlyContinue'
remove-item "$env:ProgramData\Microsoft\Windows\Start Menu\Programs\namebench.lnk" -Force -ErrorAction 'SilentlyContinue'