﻿$ErrorActionPreference = 'Stop'
$packageName  = 'mrboom'
$ShortcutName = 'MrBoom.lnk'

Remove-Item "$env:Public\Desktop\$ShortcutName" -Force -ErrorAction SilentlyContinue
Remove-Item "$env:ProgramData\Microsoft\Windows\Start Menu\Programs\$ShortcutName" -Force -ErrorAction SilentlyContinue
