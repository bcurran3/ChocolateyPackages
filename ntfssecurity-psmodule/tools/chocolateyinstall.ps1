$ErrorActionPreference = 'Stop'
$packageName = 'ntfssecurity-psmodule'

Get-PackageProvider -Name NuGet -Force
Install-Module -Name NTFSSecurity -Scope AllUsers -RequiredVersion 4.2.3 -AllowClobber -Force
Import-Module -Name NTFSSecurity
