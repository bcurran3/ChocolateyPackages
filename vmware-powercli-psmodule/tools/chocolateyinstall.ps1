$ErrorActionPreference = 'Stop'
$packageName = 'vmware-powercli-psmodule'

Get-PackageProvider -Name NuGet -Force
Install-Module -Name VMware.PowerCLI -Scope AllUsers -RequiredVersion 6.5.4.7155375 -AllowClobber -Force
Import-Module VMware.PowerCLI
