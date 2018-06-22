# Stops process $ProcessName anywhere up to 5 minutes from being called
function Start-WaitandStopActual{
$ProcessName = $env:ProcessName

$LoopMePlease=1
Do {
    Start-Sleep 5
    if((Get-Process "$ProcessName" -ea SilentlyContinue) -eq $Null){ 
      } else { 
        Stop-Process -ProcessName "$ProcessName" -Force
		break
       }	
    $LoopMePlease++
   }
Until ($LoopMePlease -gt 60)
}


  
  