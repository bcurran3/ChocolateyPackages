$ErrorActionPreference = 'Stop'
$packageName = 'choco-upgrade-all-at'
$pp          = Get-PackageParameters

# delete old task name if it exists from previous versions
$GotTask = (get-scheduledtask -TaskName "choco upgrade all at" -ErrorAction SilentlyContinue)
if ($GotTask -ne $null){
    SchTasks /DELETE /TN "choco upgrade all at" /F
   }

$GotTask = (get-scheduledtask -TaskName choco-upgrade-all-at -ErrorAction SilentlyContinue)
if ($GotTask -ne $null){
   Write-Host
   Write-Host Existing choco-upgrade-all-at scheduled task found. Keeping existing scheduled task. -foreground magenta -background blue
   Write-Host Upgrading choco-upgrade-all-at Chocolatey package files only. -foreground magenta -background blue
   Write-Host If you want to change the task runtime, uninstall and reinstall the package. -foreground magenta -background blue
   exit
   }
   
Write-Host "" 
Write-Host "choco-upgrade-all-at Summary:" -foreground magenta

if ($pp["Time"] -eq $null -or $pp["Time"] -eq ''){
     Write-Host " * TIME NOT specified, defaulting to 02:00." -foreground magenta
	 $RunTime = "02:00"
     } else {
	   $RunTime = $pp["Time"]
	   Write-Host " * TIME specified as $RunTime." -foreground magenta
      } 

if (($pp["DAILY"] -eq $null -or $pp["DAILY"] -eq '') -and ($pp["WEEKLY"] -eq $null -or $pp["WEEKLY"] -eq '')){
     Write-Host " * Defaulting to DAILY running of ""choco upgrade all -y"" at $RunTime." -foreground magenta -background blue
     SchTasks /CREATE /SC DAILY /RU SYSTEM /RL HIGHEST /TN choco-upgrade-all-at /TR "choco upgrade all -y" /ST $RunTime /F
	 SchTasks /query /tn "choco-upgrade-all-at"
	 exit
    }
		  
if ($pp["DAILY"] -eq $null -or $pp["DAILY"] -eq ''){
       Write-Host " * DAILY NOT specified." -foreground magenta
     } else {
	    Write-Host " * DAILY specified." -foreground magenta
	    SchTasks /CREATE /SC DAILY /RU SYSTEM /RL HIGHEST /TN choco-upgrade-all-at /TR "choco upgrade all -y" /ST $RunTime /F
		SchTasks /query /tn "choco-upgrade-all-at"
	    exit
	   }  
		  
if ($pp["WEEKLY"] -eq $null -or $pp["WEEKLY"] -eq ''){
     Write-Host " * WEEKLY NOT specified." -foreground magenta
     } else {
	     Write-Host " * WEEKLY specified." -foreground magenta
         if ($pp["DAY"] -eq $null -or $pp["DAY"] -eq ''){
            Write-Host " * DAY NOT specified, defaulting to SUNDAY." -foreground magenta
            SchTasks /CREATE /SC WEEKLY /D SUN /RU SYSTEM /RL HIGHEST /TN choco-upgrade-all-at /TR "choco upgrade all -y" /ST $RunTime /F
          } else {
		    $RunDay = $pp["DAY"]
            Write-Host " * DAY specified as $RunDay." -foreground magenta
		    SchTasks /CREATE /SC WEEKLY /D $pp["DAY"] /RU SYSTEM /RL HIGHEST /TN choco-upgrade-all-at /TR "choco upgrade all -y" /ST $RunTime /F
	      }
		 SchTasks /query /tn "choco-upgrade-all-at"
		}
		
