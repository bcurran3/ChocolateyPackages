$packageName = 'choco-upgrade-all-at'
$pp          = Get-PackageParameters

# delete old task name if it exists from previous versions
$GotTask = (&schtasks /query /tn "choco upgrade all at") 2> $null
if ($GotTask -ne $null){
     &SchTasks /DELETE /TN "choco upgrade all at" /F 
   }

$GotTask = (&schtasks /query /tn choco-upgrade-all-at) 2> $null
if ($GotTask -ne $null){
     Write-Host Existing choco-upgrade-all-at scheduled task found. Keeping existing scheduled task. If you want to change the task runtime or abort time, uninstall and reinstall the package. -foreground magenta -background blue
     exit
   }
   
Write-Host "" 
Write-Host "choco-upgrade-all-at Summary:" -foreground magenta

if ($pp["TIME"] -eq $null -or $pp["TIME"] -eq ''){
       Write-Host " * TIME NOT specified, defaulting to 2 AM." -foreground magenta
	   $RunTime = "02:00"
     } else {
	   $RunTime = $pp["TIME"]
	   Write-Host " * TIME specified as $RunTime." -foreground magenta
      } 

if ($pp["ABORTTIME"] -eq $null -or $pp["ABORTTIME"] -eq ''){
      Write-Host " * ABORTTIME NOT specified, defaulting to 4 AM." -foreground magenta
	  $AbortTime = "04:00"
    } else {
	  $AbortTime = $pp["ABORTTIME"]
	  Write-Host " * ABORTTIME specified as $AbortTime." -foreground magenta
    } 	  
	  
if (($pp["DAILY"] -eq $null -or $pp["DAILY"] -eq '') -and ($pp["WEEKLY"] -eq $null -or $pp["WEEKLY"] -eq '')){
      Write-Host " * DAILY or WEEKLY NOT specified, defaulting to DAILY." -foreground magenta
      SchTasks /CREATE /SC DAILY /RU SYSTEM /RL HIGHEST /TN choco-upgrade-all-at /TR "choco upgrade all -y" /ST $RunTime /F
	  SchTasks /query /tn "choco-upgrade-all-at"
	  SchTasks /CREATE /SC DAILY /RU SYSTEM /RL HIGHEST /TN choco-upgrade-all-at-abort /TR "taskkill /im choco.exe /f /t" /ST $AbortTime /F
      SchTasks /query /tn "choco-upgrade-all-at-abort"
	  Start-Sleep -s 10
 	  exit
    }
		  
if ($pp["DAILY"] -eq $null -or $pp["DAILY"] -eq ''){
       Write-Host " * DAILY NOT specified." -foreground magenta
     } else {
	   Write-Host " * DAILY specified." -foreground magenta
	   SchTasks /CREATE /SC DAILY /RU SYSTEM /RL HIGHEST /TN choco-upgrade-all-at /TR "choco upgrade all -y" /ST $RunTime /F
	   SchTasks /query /tn "choco-upgrade-all-at"
	   SchTasks /CREATE /SC DAILY /RU SYSTEM /RL HIGHEST /TN choco-upgrade-all-at-abort /TR "taskkill /im choco.exe /f /t" /ST $AbortTime /F
       SchTasks /query /tn "choco-upgrade-all-at-abort"
	   Start-Sleep -s 10
	   exit
	   }  
		  
if ($pp["WEEKLY"] -eq $null -or $pp["WEEKLY"] -eq ''){
       Write-Host " * WEEKLY NOT specified." -foreground magenta
     } else {
	   Write-Host " * WEEKLY specified." -foreground magenta
       if ($pp["DAY"] -eq $null -or $pp["DAY"] -eq ''){
            Write-Host " * DAY NOT specified, defaulting to SUNDAY." -foreground magenta
            SchTasks /CREATE /SC WEEKLY /D SUN /RU SYSTEM /RL HIGHEST /TN choco-upgrade-all-at /TR "choco upgrade all -y" /ST $RunTime /F
		    SchTasks /query /tn "choco-upgrade-all-at"			
			SchTasks /CREATE /SC WEEKLY /D SUN /RU SYSTEM /RL HIGHEST /TN choco-upgrade-all-at-abort /TR "taskkill /im choco.exe /f /t" /ST $AbortTime /F
            SchTasks /query /tn "choco-upgrade-all-at-abort"
          } else {
		    $RunDay = $pp["DAY"]
            Write-Host " * DAY specified as $RunDay." -foreground magenta
		    SchTasks /CREATE /SC WEEKLY /D $pp["DAY"] /RU SYSTEM /RL HIGHEST /TN choco-upgrade-all-at /TR "choco upgrade all -y" /ST $RunTime /F
		    SchTasks /query /tn "choco-upgrade-all-at"			
			SchTasks /CREATE /SC WEEKLY /D $pp["DAY"] /RU SYSTEM /RL HIGHEST /TN choco-upgrade-all-at-abort /TR "taskkill /im choco.exe /f /t" /ST $AbortTime /F
            SchTasks /query /tn "choco-upgrade-all-at-abort"
	      }
		}
Start-Sleep -s 10
