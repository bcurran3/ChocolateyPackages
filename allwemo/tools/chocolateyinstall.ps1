$ErrorActionPreference = 'Stop'
$packageName    = 'allwemo'
$toolsDir       = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
$url            = "$toolsDir\AllWemoSetup.msi" 

$packageArgs = @{
  packageName    = $packageName
  fileType       = 'MSI'
  url            = $url
  validExitCodes = @(0, 3010, 1641)
  silentArgs     = '/quiet /qn /norestart'
  softwareName   = 'AllWemo*'
}

Install-ChocolateyPackage @packageArgs
Remove-Item $url
