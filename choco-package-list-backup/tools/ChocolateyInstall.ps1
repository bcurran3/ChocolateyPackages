$packageName  = 'choco-package-list-backup' 
$toolsDir     = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
$script       = "choco-package-list-backup.ps1"
$shortcutName = 'Choco Package List Backup.lnk'

Move-Item "$toolsDir\$script" $env:ChocolateyInstall\bin -Force -ErrorAction 'SilentlyContinue'
Install-ChocolateyShortcut -shortcutFilePath "$env:ProgramData\Microsoft\Windows\Start Menu\Programs\$shortcutName" -targetPath "$toolsDir\choco-package-list-backup-manual.bat" -IconLocation "$toolsDir\choco-package-list-backup.ico" -RunAsAdmin
Write-Host "Edit $env:ChocolateyInstall\bin\$script to customize your backup(s)." -foreground "magenta" 
Write-Host "TO BACKUP YOUR CHOCOLATEY PACKAGE LIST:" -foreground "magenta" 
Write-Host "COMMAND PROMPT: POWERSHELL CHOCO-PACKAGE-LIST-BACKUP.PS1" -foreground "magenta" 
Write-Host "POWERSHELL    : CHOCO-PACKAGE-LIST-BACKUP.PS1" -foreground "magenta" 
Write-Host "WINDOWS       : Click Choco Package List Backup in the Start menu" -foreground "magenta" 