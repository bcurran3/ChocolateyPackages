$ErrorActionPreference = 'Stop'
$packageName = 'choco-nuspec-checker'
$scriptDir   = "$(Get-ToolsLocation)\BCURRAN3"

Remove-Item "$ENV:ChocolateyInstall\bin\CNC.bat" -Force | Out-Null
Remove-Item "$scriptDir\CNC*.*" -Force | Out-Null
if (!(Get-ChildItem -Path "$scriptDir" | Measure-Object | %{$_.Count})) {
    $ENV:Path.Replace("$scriptDir","") | Out-Null
    Remove-Item "$scriptDir" | Out-Null
   }
