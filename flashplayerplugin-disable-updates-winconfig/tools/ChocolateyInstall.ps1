$packageName = 'flashplayerplugin-disable-updates-winconfig'

SchTasks /Change /Disable /TN "Adobe Flash Player Updater" | Out-Null
Stop-Service "AdobeFlashPlayerUpdateSvc" -force | Out-Null
Set-Service "AdobeFlashPlayerUpdateSvc" -StartupType Disabled | Out-Null

Write-Host "  ** Adobe Flash Player Updater disabled." -foreground magenta
Write-Host "  ** Adobe Flash Player will only be updated by Chocolatey." -foreground magenta
