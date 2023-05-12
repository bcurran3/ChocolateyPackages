$ErrorActionPreference = 'Stop'
$packageName = 'choco-protocol-support'
$scriptDir   = "$(Get-ToolsLocation)\BCURRAN3"

New-PSDrive -Name HKCR -PSProvider Registry -Root HKEY_CLASSES_ROOT -ea SilentlyContinue | Out-Null
Remove-Item -Path "HKCR:choco" -Recurse –Force | Out-Null
Remove-Item "$env:ChocolateyInstall\bin\choco-protocol-support.bat" -Force -ErrorAction SilentlyContinue
Remove-Item "$scriptDir\choco-protocol-support.*" -Force -ErrorAction SilentlyContinue | Out-Null