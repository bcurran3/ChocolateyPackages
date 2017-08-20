$ErrorActionPreference = 'Stop'
$packageName = 'choco-persistent-packages'
$pp          = Get-PackageParameters
$GotTask     = (get-scheduledtask -TaskName "choco-persistent-packages" -ErrorAction SilentlyContinue)
$PersistentCommand = '$toolsDir\cup packages.config -y'

if ($GotTask -ne $null){
   Write-Host
   Write-Host Existing "'choco-persistent-packages'" scheduled task found. Keeping existing scheduled task. -foreground magenta 
   Write-Host Upgrading choco-persistent-packages Chocolatey package files only. -foreground magenta 
   exit
   }

if ($pp["Time"] -eq $null -or $pp["Time"] -eq ''){
     $RunTime = "00:00"
     Write-Host No time specified, defaulting to MIDNIGHT. -foreground magenta 
     } else {
       $RunTime = $pp["Time"]
	   }

SchTasks /Create /SC DAILY /RU SYSTEM /RL HIGHEST /TN "choco-persistent-packages" /TR $PersistentCommand /ST $RunTime /F
Write-Host Now configured to run choco-persistent-packages at $RunTime every day. -foreground magenta 

# Reference for possible future use:
# https://technet.microsoft.com/en-us/library/jj649816(v=wps.630).aspx

