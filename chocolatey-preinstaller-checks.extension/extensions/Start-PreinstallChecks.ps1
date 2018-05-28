function Start-PreInstallChecks{

Write-Host "PRE-INSTALLATION CHECKS:" -foreground magenta
if (Get-PendingRebootStatus) 
   {
     Write-Host "  * WARNING: Pending reboot found." -foreground red 
   } else {
     Write-Host "  * Pending reboot NOT found." -foreground green
	}
Get-WindowsInstallerStatus
Get-chocoStatus 1
Remove-Item alias:\Install-ChocolateyInstallPackage
Install-ChocolateyInstallPackage @args
}
