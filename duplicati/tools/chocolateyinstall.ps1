$ErrorActionPreference = 'Stop'
$packageName   = 'duplicati'
$installerType = 'msi'
$toolsDir      = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
$url           = 'https://github.com/duplicati/duplicati/releases/download/v2.0.1.38-2.0.1.38_canary_2016-12-27/duplicati-2.0.1.38_canary_2016-12-27-x86.msi' 
$checksum      = '41B09A5AD62DCA01B3F480108AC22A2671BB618F39683ED2BC91376B71E8A85D'
$url64         = 'https://github.com/duplicati/duplicati/releases/download/v2.0.1.38-2.0.1.38_canary_2016-12-27/duplicati-2.0.1.38_canary_2016-12-27-x64.msi' 
$checksum64    = '9ACC7F1A1C84F019B9EBD0C01351F348F938C1D9F357A2BC25F8D15E4003CF9A'
$silentArgs    = '/quiet /qn /norestart'
$validExitCodes= @(0, 3010, 1641)

$packageArgs = @{
  packageName   = $packageName
  fileType      = $installerType
  url           = $url
  url64bit      = $url64
  validExitCodes= $validExitCodes
  silentArgs    = $silentArgs
  softwareName  = 'Duplicati 2*'
  checksum      = $checksum 
  checksumType  = 'sha256' 
  checksum64    = $checksum64
  checksumType64= 'sha256'
}

Install-ChocolateyPackage @packageArgs  
  
