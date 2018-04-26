$packageName      = 'choco-package-list-backup' 
$toolsDir         = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
$Date             = Get-Date -UFormat %Y-%m-%d
$script           = "choco-package-list-backup.ps1"
$shortcutName     = 'Chocolatey Package List Backup.lnk'
$oldshortcutName = 'Choco Package List Backup.lnk'
$altshortcutName  = 'Package List Backup.lnk'
$CPLBPreExisting  = "$env:ChocolateyInstall\bin\$script"

if (Test-Path $CPLBPreExisting){
     Remove-Item "$env:ProgramData\Microsoft\Windows\Start Menu\Programs\$oldshortcutName" -Force -ErrorAction SilentlyContinue
     Rename-Item -Path $CPLBPreExisting -NewName $script"_"$Date.bak -Force -ErrorAction SilentlyContinue
    }
	
Move-Item "$toolsDir\$script" $env:ChocolateyInstall\bin -Force -ErrorAction SilentlyContinue

If (Test-Path "$env:ProgramData\Microsoft\Windows\Start Menu\Programs\Chocolatey"){
      Install-ChocolateyShortcut -shortcutFilePath "$env:ProgramData\Microsoft\Windows\Start Menu\Programs\Chocolatey\$altshortcutName" -targetPath "$env:SystemRoot\system32\WindowsPowerShell\v1.0\powershell.exe" -Arguments "-NoProfile -InputFormat None -ExecutionPolicy Bypass -Command $CPLBPreExisting" -IconLocation $env:ChocolateyInstall\choco.exe
    } else {
      Install-ChocolateyShortcut -shortcutFilePath "$env:ProgramData\Microsoft\Windows\Start Menu\Programs\$shortcutName" -targetPath "$env:SystemRoot\system32\WindowsPowerShell\v1.0\powershell.exe" -Arguments "-NoProfile -InputFormat None -ExecutionPolicy Bypass -Command $CPLBPreExisting" -IconLocation $env:ChocolateyInstall\choco.exe
	}
	
Write-Host "Running choco-package-list-backup.ps1 to create first-time backup(s)..." -foreground "magenta" 
&powershell -NoProfile -ExecutionPolicy Bypass -Command "$env:ChocolateyInstall\bin\choco-package-list-backup.ps1"
Write-Host "Edit $env:ChocolateyInstall\bin\$script to customize your backup(s)." -foreground "magenta" 
Write-Host "TO BACKUP YOUR CHOCOLATEY PACKAGE LIST AGAIN:" -foreground "magenta" 
Write-Host "Command Prompt: POWERSHELL CHOCO-PACKAGE-LIST-BACKUP.PS1" -foreground "magenta" 
Write-Host "PowerShell    : CHOCO-PACKAGE-LIST-BACKUP.PS1" -foreground "magenta" 
Write-Host "Windows       : Click Chocolatey Package List Backup in the Start menu" -foreground "magenta" 