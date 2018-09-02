# chocolatey-toast-notifications.extension v0.0.1 by Bill Curran AKA BCURRAN3 - 2018 public domain
# This function is aliased as Install-ChocolateyInstallPackage to intercept and run before
# Install-ChocolateyInstallPackage solely to add a a toast notification after running Install-ChocolateyInstallPackage.
# Got it? 

function Install-ChocolateyInstallPackageWithToastNotification{

# Remove temporary alias and resume normal operations
Remove-Item alias:\Install-ChocolateyInstallPackage 
if ($env:ChocolateyLicenseValid -eq 'true') {
    Set-Alias Install-ChocolateyInstallPackage Install-ChocolateyInstallPackageCmdlet -Force -Scope Global
   }

# Execute Install-ChocolateyInstallPackage actual (or Chocolatey licensed version alias) normally
Install-ChocolateyInstallPackage @args 

# Ensure this ONLY runs on Windows 10 - this will be removed and dealt with via a BurntToast dependency next version
$IsWin10=[Environment]::OSVersion.Version.Major
if (!($IsWin10 -eq "10")){return}

# Get name of program being installed from the .nuspec
$chocolateySoftwareName = Get-ChocolateySoftwareName

# Show toast notification
$chocolateyPackagePage = New-BTButton -Content 'Package Webpage' -Arguments "https://chocolatey.org/packages/$env:chocolateyPackageName"
New-BurntToastNotification -Text "Chocolatey ($env:chocolateyPackageName)", "$chocolateySoftwareName v$env:chocolateyPackageVersion", "Installed or updated." -Button $chocolateyPackagePage -AppLogo "$env:ChocolateyInstall\extensions\chocolatey-toast-notifications\choco.ico" 
}
