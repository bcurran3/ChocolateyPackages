$packageName = 'ntfssecurity-psmodule'
$ErrorActionPreference = 'Stop'

Install-Module -Name NTFSSecurity -RequiredVersion 4.2.3 -AllowClobber -Force
