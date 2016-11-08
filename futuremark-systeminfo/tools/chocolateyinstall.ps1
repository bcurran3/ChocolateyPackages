$ErrorActionPreference = 'Stop'
$packageName= 'futuremark-systeminfo'
$installerType = 'MSI'
$toolsDir   = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
$url        = 'https://d1ejs5fxm96rib.cloudfront.net/Futuremark_SystemInfo_v448_installer.msi' 
$silentArgs = '/quiet /qn /norestart'
$validExitCodes= @(0, 3010, 1641)

$packageArgs = @{
  packageName   = $packageName
  fileType      = $installerType
  url           = $url
  validExitCodes= $validExitCodes
  silentArgs    = $silentArgs
  softwareName  = 'Futuremark SystemInfo*'
  checksum      = 'BE64FCCEF556C97643B876F2959C00C05A46D6D7A3716D841618FCCDB2C5ECF6'
  checksumType  = 'sha256' 
}

Install-ChocolateyPackage @packageArgs  
  
