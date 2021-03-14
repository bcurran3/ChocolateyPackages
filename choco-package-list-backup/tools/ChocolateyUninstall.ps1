$ErrorActionPreference = 'Stop'
$packageName     = 'choco-package-list-backup' 
$scriptDir       = "$(Get-ToolsLocation)\BCURRAN3"
$oldshortcutName = 'Choco Package List Backup.lnk'
$shortcutName    = 'Chocolatey Package List Backup.lnk'
$altshortcutName = 'Package List Backup.lnk'

SchTasks /Delete /TN choco-package-list-backup /F

Remove-Item "$ENV:ProgramData\Microsoft\Windows\Start Menu\Programs\$oldshortcutName" -Force -ErrorAction SilentlyContinue
Remove-Item "$ENV:ProgramData\Microsoft\Windows\Start Menu\Programs\$shortcutName" -Force -ErrorAction SilentlyContinue
Remove-Item "$ENV:ProgramData\Microsoft\Windows\Start Menu\Programs\Chocolatey\$altshortcutName" -Force -ErrorAction SilentlyContinue
Remove-Item "$ENV:ChocolateyInstall\bin\choco-package-list-backup.bat" -Force -ErrorAction SilentlyContinue
Remove-Item "$scriptDir\choco-package-list-backup.*" -Force -ErrorAction SilentlyContinue | Out-Null
Remove-Item "$scriptDir\CPLB.bat" -Force -ErrorAction SilentlyContinue | Out-Null
if (!(Get-ChildItem -Path "$ENV:ChocolateyToolsLocation\BCURRAN3" | Measure-Object | %{$_.Count})) {
    $ENV:Path.Replace("$ChocolateyToolsLocation\BCURRAN3","") | Out-Null
    Remove-Item "$ENV:ChocolateyToolsLocation\BCURRAN3" | Out-Null
   }
