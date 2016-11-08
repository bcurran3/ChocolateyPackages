$packageName= 'cobian-backup' 
$softwareName = 'Cobian Backup 11 Gravity*'

if((get-process "cbVSCService11" -ea SilentlyContinue) -eq $Null){ 
    Write-Host "cbVSCService11 currently NOT running." 
  }else{ 
    Write-Host "Stopping cbVSCService11 process..."
    Stop-Process -processname "cbVSCService11" -force
  }

if((get-process "Cobian" -ea SilentlyContinue) -eq $Null){ 
    Write-Host "Cobian currently NOT running." 
  }else{ 
    Write-Host "Stopping Cobian process..."
    Stop-Process -processname "Cobian" -force
  }

if((get-process "cbInterface" -ea SilentlyContinue) -eq $Null){ 
    Write-Host "cbInterface currently NOT running." 
  }else{ 
    Write-Host "Stopping cbInterface process..."
    Stop-Process -processname "cbInterface" -force
  }

remove-item "$env:Public\Desktop\Cobian Backup 11 - Application.lnk" -Force -ErrorAction 'SilentlyContinue'

Write-Host "Silent uninstall not supported, remove via the Control Panel."


