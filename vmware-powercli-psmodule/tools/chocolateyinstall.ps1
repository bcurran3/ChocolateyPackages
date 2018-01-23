$packageName = 'vmware-powercli-psmodule'
$ErrorActionPreference = 'Stop'

Install-Module -Name VMware.PowerCLI -RequiredVersion 6.5.4.7155375 -AllowClobber -Force
