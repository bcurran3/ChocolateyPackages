function Get-WindowsInstallerStatus{
$msiexecInstances = @(Get-Process -ea silentlycontinue msiexec).count
# From my observances, msiexec sticks around after a .msi is run. Running an .msi causes 2-3 occurrences of msiexec.

if ($msiexecInstances -gt 1)
   {
    while ($msiexecInstances -gt 1)
	{
     Write-Host "  ** WARNING: Windows Installer IS currently running. Pausing 15 seconds..." -foreground red
	 Start-Sleep -seconds 15
     $msiexecInstances = @(Get-Process -ea silentlycontinue msiexec).count
	}
   }
Write-Host "  ** Windows Installer IS NOT currently running" -foreground green
}

