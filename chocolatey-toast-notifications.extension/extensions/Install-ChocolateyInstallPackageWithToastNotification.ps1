# chocolatey-toast-notifications.extension v0.0.3 by Bill Curran AKA BCURRAN3 - 2018 Copyleft Bill Curran
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

# Ensure this ONLY runs on Windows 10 - this will be removed and dealt with via a BurntToast dependency next version
$IsWin10=[Environment]::OSVersion.Version.Major
if (!($IsWin10 -eq "10")){return}

# Get name of program being installed from the .nuspec
$chocolateySoftwareName = Get-ChocolateySoftwareName

# Show toast notification
if ($env:USERNAME -eq "$env:COMPUTERNAME$"){
    If ((Get-Service $WinRM).Status -eq 'Running') {
         Invoke-Command -ComputerName $env:COMPUTERNAME -ArgumentList $env:chocolateyPackageName,$chocolateySoftwareName,$env:chocolateyPackageVersion -ScriptBlock {param([string]$chocolateyPackageName, [string]$chocolateySoftwareName, [string]$chocolateyPackageVersion) New-BurntToastNotification -Text "Chocolatey ($chocolateyPackageName)", "$chocolateySoftwareName v$chocolateyPackageVersion", "Installed or updated." -Button (New-BTButton -Content 'Package Webpage' -Arguments "https://chocolatey.org/packages/$env:chocolateyPackageName") -AppLogo "$env:ChocolateyInstall\extensions\chocolatey-toast-notifications\choco.ico"}
        } else {
          New-BurntToastNotification -Text "Chocolatey ($env:chocolateyPackageName)", "$chocolateySoftwareName v$env:chocolateyPackageVersion", "Installed or updated." -Button (New-BTButton -Content 'Package Webpage' -Arguments "https://chocolatey.org/packages/$env:chocolateyPackageName") -AppLogo "$env:ChocolateyInstall\extensions\chocolatey-toast-notifications\choco.ico"
       }
   }
}
