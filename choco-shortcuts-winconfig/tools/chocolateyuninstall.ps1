$packageName  = 'choco-shortcuts-winconfig'
$CPLBshortcut = 'Chocolatey Package List Backup.lnk'
$CheckCPLB    = "$env:ChocolateyInstall\bin\choco-package-list-backup.ps1"

if (Test-Path "$env:ChocolateyInstall\lib\choco-package-list-backup"){
  Install-ChocolateyShortcut -shortcutFilePath "$env:ProgramData\Microsoft\Windows\Start Menu\Programs\$CPLBshortcut" -targetPath "$env:SystemRoot\system32\WindowsPowerShell\v1.0\powershell.exe" -Arguments "-NoProfile -InputFormat None -ExecutionPolicy Bypass -Command $CheckCPLB" -IconLocation $env:ChocolateyInstall\choco.exe
  }
Remove-Item "$env:ProgramData\Microsoft\Windows\Start Menu\Programs\Chocolatey" -recurse -ea SilentlyContinue