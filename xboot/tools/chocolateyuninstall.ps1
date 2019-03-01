$ErrorActionPreference = 'Stop'
$packageName= 'xboot'
$ShortcutName = 'XBoot'

Remove-Item "$env:Public\Desktop\$ShortcutName.lnk" -Force -ErrorAction SilentlyContinue
Remove-Item "$env:ProgramData\Microsoft\Windows\Start Menu\Programs\$ShortcutName.lnk" -Force -ErrorAction SilentlyContinue
