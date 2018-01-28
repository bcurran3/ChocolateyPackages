$ErrorActionPreference = 'Stop'
$packageName = 'dsinternals-psmodule'

Get-PackageProvider -Name NuGet -Force
Install-Module -Name DSInternals -RequiredVersion 2.22 -AllowClobber -Force
Import-Module -Name DSInternals
