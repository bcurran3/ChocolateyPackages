$packageName     = 'choco-package-list-backup' 
$script          = 'choco-package-list-backup.ps1'
$xml             = 'choco-package-list-backup.xml'
$oldshortcutName = 'Choco Package List Backup.lnk'
$shortcutName    = 'Chocolatey Package List Backup.lnk'
$altshortcutName = 'Package List Backup.lnk'

SchTasks /Delete /TN choco-package-list-backup /F

Remove-Item "$env:ChocolateyInstall\bin\$script" -Force -ErrorAction SilentlyContinue
Remove-Item "$env:ChocolateyInstall\bin\$script*.bak" -Force -ErrorAction SilentlyContinue
Remove-Item "$env:ChocolateyInstall\bin\$xml" -Force -ErrorAction SilentlyContinue
Remove-Item "$env:ProgramData\Microsoft\Windows\Start Menu\Programs\$oldshortcutName" -Force -ErrorAction SilentlyContinue
Remove-Item "$env:ProgramData\Microsoft\Windows\Start Menu\Programs\$shortcutName" -Force -ErrorAction SilentlyContinue
Remove-Item "$env:ProgramData\Microsoft\Windows\Start Menu\Programs\Chocolatey\$altshortcutName" -Force -ErrorAction SilentlyContinue
