﻿$ErrorActionPreference = 'Stop'
$packageName  = 'teamspeak-server'
$shortcutName = 'TeamSpeak Server.lnk'

remove-item "$env:Public\Desktop\$shortcutName" -Force -ErrorAction 'SilentlyContinue'
remove-item "$env:ProgramData\Microsoft\Windows\Start Menu\Programs\$shortcutName" -Force -ErrorAction 'SilentlyContinue'

