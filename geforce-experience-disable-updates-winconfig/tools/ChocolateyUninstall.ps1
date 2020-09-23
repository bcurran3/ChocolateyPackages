$packageName = 'geforce-experience-disable-updates-winconfig'

SchTasks /Change /Enable /TN "NVIDIA GeForce Experience SelfUpdate_{B2FE1952-0186-46C3-BAEC-A80AA35AC5B8}" | Out-Null

Write-Host "  ** NVIDIA GeForce Experience SelfUpdate re-enabled." -foreground magenta
Write-Host "  ** NVIDIA GeForce Experience will be updated by NVIDIA GeForce Experience SelfUpdate and by Chocolatey." -foreground magenta