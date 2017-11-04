$packageName    = 'betterhash'
$softwareName   = 'BetterHash'

if((get-process "BetterHash" -ea SilentlyContinue) -eq $Null){ 
    Write-Host "BetterHash currently NOT running." 
  }else{ 
    Write-Host "Stopping BetterHash process..."
    Stop-Process -processname "BetterHash"
  }

