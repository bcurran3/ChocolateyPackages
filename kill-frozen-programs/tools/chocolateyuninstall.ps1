$packageName= 'kill-frozen-programs'
$IconName   = 'Kill Frozen Programs'

remove-item "$env:Public\Desktop\$IconName.lnk" -Force -ErrorAction 'SilentlyContinue'
remove-item "$env:ProgramData\Microsoft\Windows\Start Menu\Programs\$IconName.lnk" -Force -ErrorAction 'SilentlyContinue'
