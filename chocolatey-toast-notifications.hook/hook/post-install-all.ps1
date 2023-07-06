$ErrorActionPreference = 'Continue'
# chocolatey-toast-notifications.hook v1.0.0 (2023-07-01) Copyleft 2023 by Bill Curran AKA BCURRAN3
# LICENSE: GNU GPL v3 - https://www.gnu.org/licenses/gpl.html
# Suggestions? Problems? Open a GitHub issue at https://github.com/bcurran3/ChocolateyPackages/issues

# Create icon if it doesn't exist
if (!(Test-Path "$env:PUBLIC\Pictures\choco.ico")){
     [System.Reflection.Assembly]::LoadWithPartialName('System.Drawing')  | Out-Null
     [System.Drawing.Icon]::ExtractAssociatedIcon("$env:ChocolateyInstall\choco.exe").ToBitmap().Save("$env:PUBLIC\Pictures\choco.ico")
}

# Check if WinRM is running (required to send Toast machine-wide)
$WinRMStatus=(Get-Service 'WinRM').Status

# Check if upgrade or install
if (Test-Path $env:ChocolateyInstall\lib-bkp\$env:chocolateyPackageName) {$chocolateyAction="UPGRADED"} else {$chocolateyAction="INSTALLED"}

# Send Toast systemwide
if (Test-ProcessAdminRights) {
    # Start WinRM if not Running
    if ((Get-Service WinRM).Status -eq 'Stopped') {Start-Service 'WinRM' -ErrorAction SilentlyContinue}

    # Show toast notification
    if ((Get-Service WinRM).Status -eq 'Running') {
		Invoke-Command -ComputerName $env:COMPUTERNAME -ArgumentList $env:chocolateyPackageName,$env:chocolateyPackageTitle,$env:chocolateyPackageVersion,$chocolateyAction -ScriptBlock {param([string]$chocolateyPackageName, [string]$chocolateyPackageTitle, [string]$chocolateyPackageVersion, [string]$chocolateyAction) New-BurntToastNotification -Text "Chocolatey ($chocolateyPackageName)", "$chocolateyPackageTitle v$chocolateyPackageVersion $chocolateyAction." -Button (New-BTButton -Content 'Package Webpage' -Arguments "https://community.chocolatey.org/packages/$chocolateyPackageName") -AppLogo "$env:PUBLIC\Pictures\choco.ico"}
	} else {
      Write-Host "** Can't send global Toast because WinRM service is not running." -Foreground Red
	  }
    # Stop WinRM if it was previously in Stopped state
    if ($WinRMStatus -eq 'Stopped') {Stop-Service 'WinRM' -ErrorAction SilentlyContinue}
} else {
# Send Toast to running user
	if ($WinRMStatus -eq 'Running'){
		New-BurntToastNotification -Text "Chocolatey ($env:chocolateyPackageName)", "$env:chocolateyPackageTitle v$env:chocolateyPackageVersion $chocolateyAction." -Button (New-BTButton -Content 'Package Webpage' -Arguments "https://community.chocolatey.org/packages/$env:chocolateyPackageName") -AppLogo "$env:PUBLIC\Pictures\choco.ico"
	}
}
