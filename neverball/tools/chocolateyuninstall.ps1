$packageName   = 'neverball'
$shortcutName  = 'Neverball.lnk'
$shortcutName2 = 'Neverputt.lnk'

remove-item "$env:Public\Desktop\$shortcutName" -Force -ErrorAction 'SilentlyContinue'
remove-item "$env:ProgramData\Microsoft\Windows\Start Menu\Programs\$shortcutName" -Force -ErrorAction 'SilentlyContinue'
remove-item "$env:Public\Desktop\$shortcutName2" -Force -ErrorAction 'SilentlyContinue'
remove-item "$env:ProgramData\Microsoft\Windows\Start Menu\Programs\$shortcutName2" -Force -ErrorAction 'SilentlyContinue'

