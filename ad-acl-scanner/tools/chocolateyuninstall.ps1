$packageName  = 'ad-acl-scanner'
$shortcutName = 'AD ACL Scanner' 

remove-item "$env:USERPROFILE\Desktop\$shortcutName.lnk" -Force -ErrorAction 'SilentlyContinue'

