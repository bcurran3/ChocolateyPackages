# chocolatey-toast-notifications.extension v0.0.1 by Bill Curran AKA BCURRAN3 - 2018 public domain
# This function is aliased as Uninstall-ChocolateyPackage to intercept and run before
# Uninstall-ChocolateyPackage solely to add a a toast notification after running Uninstall-ChocolateyPackage.
# Got it? 

function Uninstall-ChocolateyPackageWithToastNotification{

# Remove temporary alias and resume normal operations
Remove-Item alias:\Uninstall-ChocolateyPackage

# Execute Uninstall-ChocolateyInstallPackage actual
Uninstall-ChocolateyPackage @args

# Ensure this ONLY runs on Windows 10 - this will be removed and dealt with via a BurntToast dependency next version
$IsWin10=[Environment]::OSVersion.Version.Major
if (!($IsWin10 -eq "10")){return}

# Get name of program being uninstalled from the .nuspec
$chocolateySoftwareName = Get-ChocolateySoftwareName

# Show toast notification
$chocolateyPackagePage = New-BTButton -Content 'Package Webpage' -Arguments "https://chocolatey.org/packages/$env:chocolateyPackageName"
New-BurntToastNotification -Text "Chocolatey ($env:chocolateyPackageName)", "$chocolateySoftwareName v$env:chocolateyPackageVersion", "Uninstalled." -Button $chocolateyPackagePage -AppLogo "$env:ChocolateyInstall\extensions\chocolatey-toast-notifications\choco.ico"
}
