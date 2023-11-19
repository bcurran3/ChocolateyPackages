$ErrorActionPreference = 'Stop'
$packageName     = 'choco-continuous-upgrader'
$scriptDir       = "$(Get-ToolsLocation)\BCURRAN3"

Remove-Item "$scriptDir\CCU*.*" -Force -ErrorAction SilentlyContinue | Out-Null
