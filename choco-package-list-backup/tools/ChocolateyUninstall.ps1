$packageName  = 'choco-package-list-backup' 
$script       = "choco-package-list-backup.ps1"
$shortcutName = 'Choco Package List Backup.lnk'

Remove-Item $env:ChocolateyInstall\bin\$script -Force -ErrorAction 'SilentlyContinue'
remove-item "$env:ProgramData\Microsoft\Windows\Start Menu\Programs\$shortcutName" -Force -ErrorAction 'SilentlyContinue'
