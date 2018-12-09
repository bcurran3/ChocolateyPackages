$packageName  = 'windows-iso-downloader'
$ShortcutName = 'Microsoft Windows and Office ISO Download Tool.lnk'

remove-item "$env:Public\Desktop\$ShortcutName" -Force -ErrorAction 'SilentlyContinue'
remove-item "$env:ProgramData\Microsoft\Windows\Start Menu\Programs\$ShortcutName" -Force -ErrorAction 'SilentlyContinue'

