if((get-process "ddservice" -ea SilentlyContinue) -eq $Null){ 
    Write-Host "ddservice currently NOT running." 
  }else{ 
    Write-Host "Stopping ddservice process..."
    Stop-Process -processname "ddservice"
  }

