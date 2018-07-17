# chocolatey-preinstaller-checks.extension by Bill Curran AKA BCURRAN3 - 2018 public domain
# This function is aliased as Install-ChocolateyInstallPackage to intercept and run before Install-ChocolateyInstallPackage

function Start-PreInstallChecks{
$CheckLicense = "$env:ChocolateyInstall\license\chocolatey.license.xml"

Write-Host "PRE-INSTALLATION CHECKS:" -foreground magenta
Get-PendingRebootStatus
Get-WindowsInstallerStatus
Get-chocoStatus

# Remove alias for normal operations and call Install-ChocolateyInstallPackage actual
Remove-Item alias:\Install-ChocolateyInstallPackage 
if ($env:ChocolateyLicenseValid -eq 'true') {
    Set-Alias Install-ChocolateyInstallPackage Install-ChocolateyInstallPackageCmdlet -Force -Scope Global
   }
Install-ChocolateyInstallPackage @args
}
