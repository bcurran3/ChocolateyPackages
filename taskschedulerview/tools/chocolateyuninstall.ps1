﻿$ErrorActionPreference = 'Stop'
$packageName  = 'taskschedulerview' 
$shortcutName = 'TaskSchedulerView.lnk'

remove-item "$ENV:Public\Desktop\$shortcutName" -Force -ErrorAction SilentlyContinue
remove-item "$ENV:ProgramData\Microsoft\Windows\Start Menu\Programs\$shortcutName" -Force -ErrorAction SilentlyContinue

