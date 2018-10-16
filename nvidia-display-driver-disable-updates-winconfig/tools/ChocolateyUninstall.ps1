$packageName = 'nvidia-display-driver-disable-updates-winconfig'

SchTasks /Change /Enable /TN "NvDriverUpdateCheckDaily_{B2FE1952-0186-46C3-BAEC-A80AA35AC5B8}" | Out-Null

Write-Host "  ** NVIDIA display drivers daily update check re-enabled." -foreground magenta
Write-Host "  ** NVIDIA display drivers will be checked daily and updated manually and/or by Chocolatey." -foreground magenta