$packageName= 'lan-speed-test-lite'
$softwareName = 'LAN Speed Test*'

if((get-process "LAN_SpeedTest" -ea SilentlyContinue) -eq $Null){ 
    Write-Host "LAN Speed Test currently NOT running. (Good!)" 
  }else{ 
    Write-Host "Stopping LAN_SpeedTest process..."
    Stop-Process -processname "LAN_SpeedTest"
  }

remove-item "$env:Public\Desktop\LAN Speed Test.lnk" -Force -ErrorAction 'SilentlyContinue'
