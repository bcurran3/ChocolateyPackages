# chocolatey-preinstaller-checks.extension by Bill Curran AKA BCURRAN3 - 2018 public domain
# This function is aliased as Uninstall-ChocolateyPackage to intercept and run before Uninstall-ChocolateyPackage

function Start-PreuninstallChecks{
Write-Host "PRE-UNINSTALLATION CHECKS:" -foreground magenta
Get-PendingRebootStatus
Get-WindowsInstallerStatus
Get-chocoStatus

# Remove alias for normal operations and call Uninstall-ChocolateyPackage actual
Remove-Item alias:\Uninstall-ChocolateyPackage
Uninstall-ChocolateyPackage @args
}
