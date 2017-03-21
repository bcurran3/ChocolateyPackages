$ErrorActionPreference = 'Stop'
$packageName    = 'futuremark-systeminfo'
$installerType  = 'MSI'
$toolsDir       = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
$url            = 'https://d1ejs5fxm96rib.cloudfront.net/Futuremark_SystemInfo_v50_installer.msi' 
$checksum       = '3EC325A98A128B0517030B57FA55A77E7DCA1477FD9385D7D23080331DFF1510'
$silentArgs     = '/quiet /qn /norestart'
$validExitCodes = @(0, 3010, 1641)

$packageArgs = @{
  packageName   = $packageName
  fileType      = $installerType
  url           = $url
  validExitCodes= $validExitCodes
  silentArgs    = $silentArgs
  softwareName  = 'Futuremark SystemInfo*'
  checksum      = $checksum
  checksumType  = 'sha256' 
}

Install-ChocolateyPackage @packageArgs  
  
