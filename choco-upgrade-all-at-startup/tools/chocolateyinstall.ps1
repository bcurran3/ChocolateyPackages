$ErrorActionPreference = 'Stop'
$packageName = 'choco-upgrade-all-startup'
$GotTask     = (get-scheduledtask -TaskName "Run a Choco Upgrade All at Startup" -ErrorAction SilentlyContinue) 

# delete old task name if it exists from previous versions
if ($GotTask -ne $null){
    SCHTASKS.exe /DELETE /TN "Run a Choco Upgrade All at Startup" /F
   }

# create new scheduled task to run at startup   
SchTasks /Create /SC ONSTART /RU SYSTEM /RL HIGHEST /TN "choco-upgrade-all-startup" /TR "choco upgrade all -y" /F
Write-Host "Now configured to run ""choco upgrade all -y"" at Windows startup." -foreground magenta 
