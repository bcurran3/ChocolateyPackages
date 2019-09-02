$ErrorActionPreference = 'Stop'
$packageName = 'choco-package-deprecater'
$scriptDir   = "$(Get-ToolsLocation)\BCURRAN3"

Remove-Item "$scriptDir\CPDR*.*" -Force -ErrorAction SilentlyContinue | Out-Null
if (!(Get-ChildItem -Path "$ENV:ChocolateyToolsLocation\BCURRAN3" | Measure-Object | %{$_.Count})) {
   $ENV:Path.Replace("$ChocolateyToolsLocation\BCURRAN3","") | Out-Null
   Remove-Item "$ENV:ChocolateyToolsLocation\BCURRAN3" | Out-Null
   }