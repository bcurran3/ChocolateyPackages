# v0.0.2.1
$packageName  = 'choco-shortcuts-winconfig'

# move icon for choco-cleaner if installed
# https://chocolatey.org/packages/choco-cleaner
$shortcutName     = 'Choco Cleaner.lnk'
$altshortcutName  = 'Chocolatey Cleaner.lnk'
$CheckCC          = "$env:ProgramData\Microsoft\Windows\Start Menu\Programs\Chocolatey\$shortcutName"
if (Test-Path $CheckCC){
    Install-ChocolateyShortcut -shortcutFilePath "$env:ProgramData\Microsoft\Windows\Start Menu\Programs\$altshortcutName" -targetPath "$env:SystemRoot\system32\WindowsPowerShell\v1.0\powershell.exe" -Arguments "-NoProfile -InputFormat None -ExecutionPolicy Bypass -Command $env:ChocolateyInstall\bin\choco-cleaner.ps1" -WorkingDirectory $env:ChocolateyInstall\bin\ -RunAsAdmin
   }

# move icon for choco-package-list-backup if installed
# https://chocolatey.org/packages/choco-package-list-backup
$shortcutName    = 'Package List Backup.lnk'
$altshortcutName = 'Chocolatey Package List Backup.lnk'
$CheckCPLB       = "$env:ProgramData\Microsoft\Windows\Start Menu\Programs\Chocolatey\$shortcutName"
if (Test-Path $CheckCPLB){
	Install-ChocolateyShortcut -shortcutFilePath "$env:ProgramData\Microsoft\Windows\Start Menu\Programs\$altshortcutName" -targetPath "$env:SystemRoot\system32\WindowsPowerShell\v1.0\powershell.exe" -Arguments "-NoProfile -InputFormat None -ExecutionPolicy Bypass -Command $env:ChocolateyInstall\bin\choco-package-list-backup.ps1" -WorkingDirectory $env:ChocolateyInstall\bin\ -RunAsAdmin
   }	

# move icon for chocolateypowershell if installed
# https://chocolatey.org/packages/chocolateypowershell
$shortcutName = 'ChocolateyPowerShell.lnk'
$CheckCPS     = "$env:ProgramData\Microsoft\Windows\Start Menu\Programs\Chocolatey\$shortcutName"
if (Test-Path $CheckCPS){
    Install-ChocolateyShortcut -shortcutFilePath "$env:ProgramData\Microsoft\Windows\Start Menu\Programs\$shortcutName" -targetPath "$env:SystemRoot\system32\WindowsPowerShell\v1.0\powershell.exe" -Arguments "-noexit -c $env:ChocolateyInstall\lib\chocolateypowershell\tools\ChocolateyEnvironment.ps1" -WorkingDirectory "$env:SystemDrive\" -RunAsAdmin
   }

Remove-Item "$env:ProgramData\Microsoft\Windows\Start Menu\Programs\Chocolatey" -recurse -ea SilentlyContinue
Write-Host "  ** Chocolatey folder in Windows Start Menu removed." -foreground magenta