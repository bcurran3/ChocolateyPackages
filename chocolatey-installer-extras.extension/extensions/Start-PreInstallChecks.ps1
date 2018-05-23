function Start-PreInstallChecks{

Write-Host "PRE-INSTALLATION STATUS:" -foreground magenta
if (Get-PendingRebootStatus) 
   {
    Write-Host "  ** WARNING: Pending reboot found." -foreground red 
   } else {
     Write-Host "  ** Pending reboot NOT found." -foreground green
	}
Get-WindowsInstallerStatus
Get-chocoStatus
Remove-Item alias:\Install-ChocolateyPackage
Install-ChocolateyPackage @args
}
