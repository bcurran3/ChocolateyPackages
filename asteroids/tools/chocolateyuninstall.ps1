﻿$ErrorActionPreference = 'Stop'
$packageName = 'asteroids' 
$Shortcut    = 'Asteroids.lnk'

remove-item "$env:Public\Desktop\$Shortcut" -Force -ErrorAction 'SilentlyContinue'
remove-item "$env:ProgramData\Microsoft\Windows\Start Menu\Programs\$Shortcut" -Force -ErrorAction 'SilentlyContinue'

