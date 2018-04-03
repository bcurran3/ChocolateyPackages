$packageName = 'netstat-viewer'

remove-item "$env:Public\Desktop\Netstat Viewer.lnk" -Force -ErrorAction 'SilentlyContinue'
remove-item "$env:ProgramData\Microsoft\Windows\Start Menu\Programs\Netstat Viewer.lnk" -Force -ErrorAction 'SilentlyContinue'