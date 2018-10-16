$packageName = 'geforce-experience-disable-updates-winconfig'

SchTasks /Change /Disable /TN "NVIDIA GeForce Experience SelfUpdate_{B2FE1952-0186-46C3-BAEC-A80AA35AC5B8}" | Out-Null

Write-Host "  ** NVIDIA GeForce Experience SelfUpdate disabled." -foreground magenta
Write-Host "  ** NVIDIA GeForce Experience will only be updated by Chocolatey." -foreground magenta
