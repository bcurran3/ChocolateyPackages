function Start-PreuninstallChecks{

Write-Host "PRE-UNINSTALLATION CHECKS:" -foreground magenta
if (Get-PendingRebootStatus) 
   {
     Write-Host "  * WARNING: Pending reboot found." -foreground red 
   } else {
     Write-Host "  * Pending reboot NOT found." -foreground green
	}
Get-WindowsInstallerStatus
Get-chocoStatus 2
Remove-Item alias:\Uninstall-ChocolateyPackage
Uninstall-ChocolateyPackage @args
}
