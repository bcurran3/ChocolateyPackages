$packageName = 'choco-upgrade-all-startup'

# delete old task name if it exists from versions 2017.01.10 and earlier
$GotTask = (&schtasks.exe /query /tn "Run a Choco Upgrade All at Startup") 2> $null
if ($GotTask -ne $null){
    &schtasks.exe /DELETE /TN "Run a Choco Upgrade All at Startup" /F
   }

# create new scheduled task to run at startup if it doesn't already exist
$GotTask = (&schtasks.exe /query /tn "choco-upgrade-all-startup") 2> $null
if ($GotTask -ne $null){
	 Write-Host "Existing choco-upgrade-all-startup scheduled task found. Keeping existing scheduled task." -foreground magenta
	 exit	
   } else {
    Write-Host " "
    &schtasks.exe /Create /SC ONSTART /RU SYSTEM /RL HIGHEST /TN "choco-upgrade-all-startup" /TR "choco upgrade all -y" /F
    Write-Host "Now configured to run ""choco upgrade all -y"" at Windows startup." -foreground magenta
	}

	
	
