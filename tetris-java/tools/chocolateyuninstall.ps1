﻿$packageName  = 'tetris-java'
$ShortcutName = 'tetris Java.lnk'

remove-item "$env:Public\Desktop\$ShortcutName" -Force -ErrorAction 'SilentlyContinue'
remove-item "$env:ProgramData\Microsoft\Windows\Start Menu\Programs\$ShortcutName" -Force -ErrorAction 'SilentlyContinue'