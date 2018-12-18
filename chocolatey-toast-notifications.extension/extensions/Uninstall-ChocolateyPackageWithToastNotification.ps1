# chocolatey-toast-notifications.extension v0.0.3 by Bill Curran AKA BCURRAN3 - 2018 Copyleft Bill Curran
# This function is aliased as Uninstall-ChocolateyPackage to intercept and run before
# Uninstall-ChocolateyPackage solely to add a a toast notification after running Uninstall-ChocolateyPackage.
# Got it? No? Read it again.

function Uninstall-ChocolateyPackageWithToastNotification{

# support for chocolatey-preinstaller-checks.extension
if (Get-Command Start-PreuninstallChecks -ErrorAction SilentlyContinue){Start-PreUninstallChecks}

# Remove temporary alias and resume normal operations
Remove-Item alias:\Uninstall-ChocolateyPackage -ErrorAction SilentlyContinue

# Execute Uninstall-ChocolateyInstallPackage actual
Uninstall-ChocolateyPackage @args

# Get name of program being uninstalled from the .nuspec
$chocolateySoftwareName = Get-ChocolateySoftwareName

# Show toast notification
if ($env:USERNAME -eq "$env:COMPUTERNAME$"){
    If ((Get-Service $WinRM).Status -eq 'Running') {
         Invoke-Command -ComputerName $env:COMPUTERNAME -ArgumentList $env:chocolateyPackageName,$chocolateySoftwareName,$env:chocolateyPackageVersion -ScriptBlock {param([string]$chocolateyPackageName, [string]$chocolateySoftwareName, [string]$chocolateyPackageVersion) New-BurntToastNotification -Text "Chocolatey ($chocolateyPackageName)", "$chocolateySoftwareName v$chocolateyPackageVersion", "Uninstalled." -Button (New-BTButton -Content 'Package Webpage' -Arguments "https://chocolatey.org/packages/$env:chocolateyPackageName") -AppLogo "$env:ChocolateyInstall\extensions\chocolatey-toast-notifications\choco.ico"}
   }
 } else {
   New-BurntToastNotification -Text "Chocolatey ($env:chocolateyPackageName)", "$chocolateySoftwareName v$env:chocolateyPackageVersion", "Uninstalled." -Button (New-BTButton -Content 'Package Webpage' -Arguments "https://chocolatey.org/packages/$env:chocolateyPackageName") -AppLogo "$env:ChocolateyInstall\extensions\chocolatey-toast-notifications\choco.ico"
  }
}
