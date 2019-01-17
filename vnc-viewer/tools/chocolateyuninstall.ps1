$packageName    = 'vnc-viewer'
$shortcutName   = 'VNC Viewer' 

Remove-Item "$ENV:PUBLIC\Desktop\$shortcutName.lnk" -Force -ErrorAction SilentlyContinue
Remove-Item "$ENV:ProgramData\Microsoft\Windows\Start Menu\Programs\$shortcutName.lnk" -Force -ErrorAction SilentlyContinue
