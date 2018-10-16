$packageName = 'flashplayerplugin-disable-updates-winconfig'

SchTasks /Change /Enable /TN "Adobe Flash Player Updater" | Out-Null
Set-Service "AdobeFlashPlayerUpdateSvc" -StartupType Manual | Out-Null

Write-Host "  ** Adobe Flash Player Updater re-enabled." -foreground magenta
Write-Host "  ** Adobe Flash Player will be updated by Adobe Flash Player Updater and Chocolatey." -foreground magenta