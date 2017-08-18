$ErrorActionPreference = 'Stop'
$packageName = 'choco-upgrade-all-at'
$pp          = Get-PackageParameters
$GotTask     = (get-scheduledtask -TaskName "choco upgrade all at" -ErrorAction SilentlyContinue) 

if ($GotTask -ne $null){
   Write-Host
   Write-Host Existing "'choco upgrade all at'" scheduled task found. Keeping existing scheduled task. -foreground magenta 
   Write-Host Upgrading choco-upgrade-all-at Chocolatey package files only. -foreground magenta 
   exit
   }

if ($pp["Time"] -eq $null -or $pp["Time"] -eq ''){
     $RunTime = "00:00"
     Write-Host No time specified, defaulting to MIDNIGHT. -foreground magenta 
     } else {
       $RunTime = $pp["Time"]
	   }

SchTasks /Create /SC DAILY /RU SYSTEM /RL HIGHEST /TN "choco upgrade all at" /TR "choco upgrade all -y" /ST $RunTime /F
Write-Host Now configured to run choco upgrade all at $RunTime every day. -foreground magenta 

# Reference for possible future use:
# https://technet.microsoft.com/en-us/library/jj649816(v=wps.630).aspx

