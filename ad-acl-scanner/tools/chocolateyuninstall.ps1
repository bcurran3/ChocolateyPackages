$packageName  = 'ad-acl-scanner'
$fileName     = 'ADACLScan.ps1'
$shortcutName = 'AD ACL Scanner' 
$FileFullpath = Join-Path $ToolsDir $fileName

remove-item "$env:Public\Desktop\$shortcutName.lnk" -Force -ErrorAction 'SilentlyContinue'
remove-item "$env:ProgramData\Microsoft\Windows\Start Menu\Programs\$shortcutName.lnk" -Force -ErrorAction 'SilentlyContinue'

