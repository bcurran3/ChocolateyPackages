function Get-WindowsInstallerStatus{
$msiexecInstances = @(Get-Process -ea silentlycontinue msiexec).count
# From my observations, msiexec sticks around after a .msi is run. Running a .msi causes 2-3 occurrences of msiexec.

if ($msiexecInstances -gt 1)
   {
    while ($msiexecInstances -gt 1)
	{
     Write-Host "  * WARNING: Windows Installer IS currently running. Pausing 30 seconds..." -foreground red
	 Start-Sleep -seconds 30
     $msiexecInstances = @(Get-Process -ea silentlycontinue msiexec).count
	}
   }
Write-Host "  * Windows Installer IS NOT currently running" -foreground green
}

