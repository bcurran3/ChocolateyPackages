﻿$ErrorActionPreference = 'Stop'
$packageName = 'choco-package-deprecater'
$scriptDir   = "$(Get-ToolsLocation)\BCURRAN3"

Remove-Item "$ENV:ChocolateyInstall\bin\cdeprecate.bat" -Force | Out-Null
Remove-Item "$scriptDir\cdeprecate.*" -Force -ErrorAction SilentlyContinue | Out-Null
if (!(Get-ChildItem -Path "$ENV:ChocolateyToolsLocation\BCURRAN3" | Measure-Object | ForEach-Object{$_.Count})) {
   $ENV:Path.Replace("$ChocolateyToolsLocation\BCURRAN3","") | Out-Null
   Remove-Item "$ENV:ChocolateyToolsLocation\BCURRAN3" | Out-Null
   }