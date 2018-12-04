# chocolatey-misc-helpers.extension v0.0.3 (12-04-2018) by Bill Curran - public domain
# Start-WaitandStopActual.ps1 - Stops process $ProcessName anywhere up to 5 minutes after being called.
# This function is called by Start-WaitandStop.ps1 and should not be used directly.

function Start-WaitandStopActual{
$ProcessName = $env:ProcessName

$LoopMePlease=1
Do {
    Start-Sleep 5
    if((Get-Process "$ProcessName" -ea SilentlyContinue) -eq $Null){ 
      } else { 
        Write-Verbose "  ** Stopping $ProcessName process..."	  
        Stop-Process -ProcessName "$ProcessName" -Force
		break
       }	
    $LoopMePlease++
   }
Until ($LoopMePlease -gt 60)
}


  
  