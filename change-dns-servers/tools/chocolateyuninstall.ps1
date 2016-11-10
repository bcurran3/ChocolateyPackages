$packageName= 'change-dns-servers'
$IconName   = 'Change DNS Servers'

remove-item "$env:Public\Desktop\$IconName.lnk" -Force -ErrorAction 'SilentlyContinue'
remove-item "$env:ProgramData\Microsoft\Windows\Start Menu\Programs\$IconName.lnk" -Force -ErrorAction 'SilentlyContinue'
