# chocolatey-preinstaller-checks.extension v0.0.2-pre01 by Bill Curran AKA BCURRAN3 - 2018 public domain
# Start-PreinstallChecks.ps1 - aliased as Install-ChocolateyInstallPackage to intercept and run before Install-ChocolateyInstallPackage then returns original functionality and passes on to install the package
# See/Edit Chocolatey-Preinstaller-Checks.xml for options
# If this extension stops your packages from becoming lost and unmanaged,
# consider becoming a patron of me at https://www.patreon.com/bcurran3 :)

function Start-PreInstallChecks{
$CheckLicense = "$env:ChocolateyInstall\license\chocolatey.license.xml"

Write-Host "PRE-INSTALLATION CHECKS:" -foreground magenta
Get-PendingRebootStatus
Get-WindowsInstallerStatus
Get-chocoStatus

# Remove alias(es) for normal operations
Remove-Item alias:\Install-ChocolateyInstallPackage 
if ($env:ChocolateyLicenseValid -eq 'true') {
    Set-Alias Install-ChocolateyInstallPackage Install-ChocolateyInstallPackageCmdlet -Force -Scope Global
   }

################ BETA ABORTION BELOW #############

# Abort package install/upgrade due to multiple instances of either Chocolatey or Windows Installer running
# default=false
if ($global:CPCEAbort -eq "true")
    {
	 if (Test-Path $env:ChocolateyInstall\lib-bkp\$env:packageName)
	    {
# If the package is an upgrade, delete the newly downloaded package files and move the old package files back		
		 Remove-Item $env:ChocolateyInstall\lib\$env:packageName -Recurse -Force -ErrorAction SilentlyContinue
		 Move-Item -Path $env:ChocolateyInstall\lib-bkp\$env:packageName -Destination $env:ChocolateyInstall\lib -Force -ErrorAction SilentlyContinue
		} else {
# If the package is new install, delete the package files so the package installation aborts
		  Remove-Item $env:ChocolateyInstall\lib\$env:packageName -Recurse -Force -ErrorAction SilentlyContinue
		}
	 return
    } else { 
# calling Install-ChocolateyInstallPackage actual
	  Install-ChocolateyInstallPackage @args 
	}
}
