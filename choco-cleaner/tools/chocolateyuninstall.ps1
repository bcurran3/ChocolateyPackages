$ErrorActionPreference = 'Stop'
$packageName     = 'choco-cleaner'
$scriptDir       = "$(Get-ToolsLocation)\BCURRAN3"
$shortcutName    = 'Choco Cleaner.lnk'
$altshortcutName = 'Chocolatey Cleaner.lnk'

SchTasks /Delete /TN “choco-cleaner” /F

Remove-Item "$ENV:ProgramData\Microsoft\Windows\Start Menu\Programs\$shortcutName" -Force -ErrorAction SilentlyContinue
Remove-Item "$ENV:ProgramData\Microsoft\Windows\Start Menu\Programs\$altshortcutName" -Force -ErrorAction SilentlyContinue
Remove-Item "$ENV:ProgramData\Microsoft\Windows\Start Menu\Programs\Chocolatey\$shortcutName" -Force -ErrorAction SilentlyContinue
Remove-Item "$scriptDir\choco-cleaner.*" -Force -ErrorAction SilentlyContinue | Out-Null
if (!(Get-ChildItem -Path "$ENV:ChocolateyToolsLocation\BCURRAN3" | Measure-Object | %{$_.Count})) {
    $ENV:Path.Replace("$ChocolateyToolsLocation\BCURRAN3","") | Out-Null
    Remove-Item "$ENV:ChocolateyToolsLocation\BCURRAN3" | Out-Null
   }
