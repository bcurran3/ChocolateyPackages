$ErrorActionPreference = 'Stop'
$packageName    = 'betterhash'
$softwareName   = 'BetterHash'

if($Null -eq (get-process "BetterHash" -ea SilentlyContinue)){ 
    Write-Host "BetterHash currently NOT running." 
  }else{ 
    Write-Host "Stopping BetterHash process..."
    Stop-Process -processname "BetterHash"
  }

