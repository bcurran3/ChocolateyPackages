$packageName= 'game-key-revealer.portable'
$ShortcutName = 'Game Key Revealer'

Uninstall-ChocolateyZipPackage
remove-item "$env:Public\Desktop\$ShortcutName.lnk" -Force -ErrorAction 'SilentlyContinue'
remove-item "$env:ProgramData\Microsoft\Windows\Start Menu\Programs\$ShortcutName.lnk" -Force -ErrorAction 'SilentlyContinue'