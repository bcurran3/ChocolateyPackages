# chocolatey-preinstaller-checks.extension by Bill Curran AKA BCURRAN3 - 2018 public domain
# Supposedly choco-agent reports as choco.exe?? per gep13. Unknown, can't test but doesn't make sense.

function Get-chocoStatus{

if((get-process "chocolatey-agent" -ea SilentlyContinue) -eq $Null){
    } else {
    Write-Host "  * chocolatey-agent.exe found running, possibly can't check for multiple instances at this time. (Sorry!) " -foreground yellow
	break
  }

$chocoInstances = (Get-chocoCounts)

if ($chocoInstances -ge 2)
    {
     while ($chocoInstances -gt 1)
     {
	  # exclude current instance from status report
      $chocoInstances = $chocoInstances-1
      Write-Host "  * WARNING: $chocoInstances other instance(s) of choco.exe actual found running. Pausing 30 seconds..." -foreground red
	  Start-Sleep -seconds 30
      $chocoInstances = (Get-chocoCounts)
     }
	} else {
	  Write-Host "  * choco.exe IS NOT running multiple instances." -foreground green
	 }
}
