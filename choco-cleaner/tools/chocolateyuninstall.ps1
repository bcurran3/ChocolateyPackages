$ErrorActionPreference = 'Stop'
$packageName      = 'choco-cleaner'
$script           = 'choco-cleaner.ps1'
$xml              = 'choco-cleaner.xml'
$shortcutName     = 'Choco Cleaner.lnk'
$altshortcutName  = 'Chocolatey Cleaner.lnk'

SchTasks /Delete /TN “choco-cleaner” /F

Remove-Item "$env:ChocolateyInstall\bin\$script" -Force -ErrorAction SilentlyContinue
Remove-Item "$env:ChocolateyInstall\bin\$xml" -Force -ErrorAction SilentlyContinue
Remove-Item "$env:ProgramData\Microsoft\Windows\Start Menu\Programs\$altshortcutName" -Force -ErrorAction SilentlyContinue
Remove-Item "$env:ProgramData\Microsoft\Windows\Start Menu\Programs\Chocolatey\$shortcutName" -Force -ErrorAction SilentlyContinue