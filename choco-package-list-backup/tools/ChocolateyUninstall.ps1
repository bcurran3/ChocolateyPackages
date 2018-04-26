$packageName     = 'choco-package-list-backup' 
$script          = 'choco-package-list-backup.ps1'
$oldshortcutName = 'Choco Package List Backup.lnk'
$shortcutName    = 'Chocolatey Package List Backup.lnk'

Remove-Item "$env:ChocolateyInstall\bin\$script" -Force -ErrorAction SilentlyContinue
Remove-Item "$env:ChocolateyInstall\bin\$script*.bak" -Force -ErrorAction SilentlyContinue
Remove-Item "$env:ProgramData\Microsoft\Windows\Start Menu\Programs\$oldshortcutName" -Force -ErrorAction SilentlyContinue
Remove-Item "$env:ProgramData\Microsoft\Windows\Start Menu\Programs\$shortcutName" -Force -ErrorAction SilentlyContinue
Remove-Item "$env:ProgramData\Microsoft\Windows\Start Menu\Programs\Chocolatey\Package List Backup.lnk" -Force -ErrorAction SilentlyContinue
