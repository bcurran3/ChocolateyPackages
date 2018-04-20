$ErrorActionPreference = 'Stop'
$packageName = 'vmware-powercli-psmodule'

$PSversion = $PSVersionTable.PSVersion.Major
if ($PSversion -lt "5")
   {
    Write-Host "PowerShell < v5 detected." -forground red -background blue
	Write-Host "If PowerShell v5 was installed as a dependency, you need to reboot before installing this package." -foreground red -background blue
	throw
   }

Get-PackageProvider -Name NuGet -Force
Install-Module -Name VMware.PowerCLI -Scope AllUsers -RequiredVersion 10.0.0.7895300 -AllowClobber -Force
Import-Module VMware.PowerCLI
