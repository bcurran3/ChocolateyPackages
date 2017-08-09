$packageName  = 'choco-package-list-backup' 
$toolsDir     = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
$script       = "choco-package-list-backup.ps1"

Move-Item "$toolsDir\$script" $env:ChocolateyInstall\bin -Force -ErrorAction 'SilentlyContinue'
Write-Host "Edit $env:ChocolateyInstall\bin\$script to customize your backup(s)." -foreground "magenta" –backgroundcolor "blue"
Write-Host "From PowerShell, type CHOCO-PACKAGE-LIST-BACKUP.PS1 to backup your Chocolatey packages list." -foreground "magenta" –backgroundcolor "blue"
Write-Host "From Command Prompt, type POWERSHELL CHOCO-PACKAGE-LIST-BACKUP.PS1 to backup your Chocolatey packages list." -foreground "magenta" –backgroundcolor "blue"

