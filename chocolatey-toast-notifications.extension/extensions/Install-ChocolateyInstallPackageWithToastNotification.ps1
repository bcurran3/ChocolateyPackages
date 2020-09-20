﻿# chocolatey-toast-notifications.extension v0.0.4 by Bill Curran AKA BCURRAN3 - 2018-2020 Copyleft Bill Curran
# This function is aliased as Uninstall-ChocolateyPackage to intercept and run before
# Uninstall-ChocolateyPackage solely to add a a toast notification after running Uninstall-ChocolateyPackage.
# Got it? No? Read it again.

function Install-ChocolateyInstallPackageWithToastNotification{

# support for chocolatey-preinstaller-checks.extension
if (Get-Command Start-PreInstallChecks -ErrorAction SilentlyContinue){Start-PreInstallChecks}

# Remove temporary alias and resume normal operations
Remove-Item alias:\Install-ChocolateyInstallPackage -ErrorAction SilentlyContinue
if ($env:ChocolateyLicenseValid -eq 'true') {
    Set-Alias Install-ChocolateyInstallPackage Install-ChocolateyInstallPackageCmdlet -Force -Scope Global
   }

# Execute Install-ChocolateyInstallPackage actual (or Chocolatey licensed version alias) normally
Install-ChocolateyInstallPackage @args 

# Get name of program being installed from the .nuspec
$chocolateySoftwareName = Get-ChocolateySoftwareName

# Show toast notification
    If ((Get-Service WinRM).Status -eq 'Running') {
         Invoke-Command -ComputerName $env:COMPUTERNAME -ArgumentList $env:chocolateyPackageName,$chocolateySoftwareName,$env:chocolateyPackageVersion -ScriptBlock {param([string]$chocolateyPackageName, [string]$chocolateySoftwareName, [string]$chocolateyPackageVersion) New-BurntToastNotification -Text "Chocolatey ($chocolateyPackageName)", "$chocolateySoftwareName v$chocolateyPackageVersion", "Installed or updated." -Button (New-BTButton -Content 'Package Webpage' -Arguments "https://chocolatey.org/packages/$env:chocolateyPackageName") -AppLogo "$env:ChocolateyInstall\extensions\chocolatey-toast-notifications\choco.ico"}
   } else {
     Write-Host "** Can't send global Toast because WinRM service is not running." -Foreground red
	 }
 }
