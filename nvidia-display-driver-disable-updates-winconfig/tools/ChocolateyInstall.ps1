$packageName = 'nvidia-display-driver-disable-updates-winconfig'

SchTasks /Change /Disable /TN "NvDriverUpdateCheckDaily_{B2FE1952-0186-46C3-BAEC-A80AA35AC5B8}" | Out-Null

Write-Host "  ** NVIDIA display driver daily update checks disabled." -foreground magenta
Write-Host "  ** NVIDIA display drivers will only be updated by Chocolatey." -foreground magenta
