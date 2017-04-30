$packageName= 'resedit' 

remove-item "$env:Public\Desktop\ResEdit.lnk" -Force -ErrorAction 'SilentlyContinue'
remove-item "$env:ProgramData\Microsoft\Windows\Start Menu\Programs\ResEdit.lnk" -Force -ErrorAction 'SilentlyContinue'

