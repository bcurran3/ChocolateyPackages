$ErrorActionPreference = 'Stop'
$packageName = 'choco-nuspec-checker'
$scriptDir   = "$(Get-ToolsLocation)\BCURRAN3"

Remove-Item "$ENV:ChocolateyInstall\bin\CNC.bat" -Force | Out-Null
Remove-Item "$scriptDir\CNC*.*" -Force | Out-Null
if (!(Get-ChildItem -Path "$ENV:ChocolateyToolsLocation\BCURRAN3" | Measure-Object | ForEach-Object{$_.Count})) {
   $ENV:Path.Replace("$ChocolateyToolsLocation\BCURRAN3","") | Out-Null
   Remove-Item "$ENV:ChocolateyToolsLocation\BCURRAN3" | Out-Null
   }
