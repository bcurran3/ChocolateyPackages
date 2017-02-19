$packageName   = 'snappy-driver-installer' 
$shortcutName  = 'Snappy Driver Installer' 

remove-item "$env:Public\Desktop\$shortcutName.lnk" -Force -ErrorAction 'SilentlyContinue'
remove-item "$env:ProgramData\Microsoft\Windows\Start Menu\Programs\$shortcutName.lnk" -Force -ErrorAction 'SilentlyContinue'
