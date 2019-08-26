$ErrorActionPreference = 'Stop'
$packageName = 'choco-nuspec-checker'
$scriptDir   = "$(Get-ToolsLocation)\BCURRAN3"

Remove-Item "$scriptDir\CNC*.*" -Force -ErrorAction SilentlyContinue | Out-Null
