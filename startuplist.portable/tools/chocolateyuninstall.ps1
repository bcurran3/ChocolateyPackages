$packageName  = 'startuplist.portable'
$ShortcutName = 'StartupList'

Uninstall-ChocolateyZipPackage
remove-item "$ENV:Public\Desktop\$ShortcutName.lnk" -Force -ErrorAction SilentlyContinue
remove-item "$ENV:ProgramData\Microsoft\Windows\Start Menu\Programs\$ShortcutName.lnk" -Force -ErrorAction SilentlyContinue