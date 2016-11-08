$packageName='gpu-z' 

remove-item "$env:Public\Desktop\GPU-Z.lnk" -Force -ErrorAction 'SilentlyContinue'
remove-item "$env:ProgramData\Microsoft\Windows\Start Menu\Programs\GPU-Z.lnk" -Force -ErrorAction 'SilentlyContinue'
