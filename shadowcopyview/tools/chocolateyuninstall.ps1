﻿$ErrorActionPreference = 'Stop'
$packageName  = 'shadowcopyview' 
$shortcutName = 'ShadowCopyView.lnk'

remove-item "$env:Public\Desktop\$shortcutName" -Force -ErrorAction 'SilentlyContinue'
remove-item "$env:ProgramData\Microsoft\Windows\Start Menu\Programs\$shortcutName" -Force -ErrorAction 'SilentlyContinue'

