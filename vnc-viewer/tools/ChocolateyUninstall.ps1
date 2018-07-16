$packageName    = 'vnc-viewer'
$shortcutName   = 'VNC Viewer' 

remove-item "$env:PUBLIC\Desktop\$shortcutName.lnk" -Force -ErrorAction 'SilentlyContinue'
remove-item "$env:ProgramData\Microsoft\Windows\Start Menu\Programs\$shortcutName.lnk" -Force -ErrorAction 'SilentlyContinue'

