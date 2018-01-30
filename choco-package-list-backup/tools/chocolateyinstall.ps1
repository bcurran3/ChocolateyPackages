$packageName  = 'choco-package-list-backup' 
$toolsDir     = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
$script       = "choco-package-list-backup.ps1"

Move-Item "$toolsDir\$script" $env:ChocolateyInstall\bin -Force -ErrorAction 'SilentlyContinue'
Write-Host "Edit $env:ChocolateyInstall\bin\$script to customize your backup(s)." -foreground "magenta" 
Write-Host "TO BACKUP YOUR CHOCOLATEY PACKAGE LIST:" -foreground "magenta" 
Write-Host "COMMAND PROMPT: POWERSHELL CHOCO-PACKAGE-LIST-BACKUP.PS1" -foreground "magenta" 
Write-Host "POWERSHELL    : CHOCO-PACKAGE-LIST-BACKUP.PS1" -foreground "magenta" 
Write-Host "WINDOWS       : double click choco-package-list-backup-manual.bat in \ProgramData\chocolatey\lib\choco-package-list-backup\tools" -foreground "magenta" 