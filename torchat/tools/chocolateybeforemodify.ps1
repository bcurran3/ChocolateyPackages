if((get-process "tor" -ea SilentlyContinue) -eq $Null){ 
    Write-Host "tor currently NOT running." 
  }else{ 
    Write-Host "Stopping tor process..."
    Stop-Process -processname "tor"
  }

if((get-process "torchat" -ea SilentlyContinue) -eq $Null){ 
    Write-Host "torchat currently NOT running." 
  }else{ 
    Write-Host "Stopping torchat process..."
    Stop-Process -processname "torchat"
  }
  