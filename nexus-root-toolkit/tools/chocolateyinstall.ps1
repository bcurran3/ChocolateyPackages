$packageName    = 'nexus-root-toolkit'
$installerType  = 'exe'
$url            = 'https://nl1.androidfilehost.com/dl/3iz1hq8b1IqKrbuKZT_CiA/1490747235/24728673521238129/NRT_v2.1.9.sfx.exe'
$checksum       = '61DC26A304A3835AEDFC3A1E7BD67F76BEE6673F5E22E43729A1A706D3EF8820'
$silentArgs     = '/S'
$toolsDir       = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
$validExitCodes = @(0,1)
$softwareName   = 'Nexus Root Toolkit'

$packageArgs = @{
  packageName   = $packageName
  unzipLocation = $toolsDir  
  fileType      = $installerType
  url           = $url
  validExitCodes= $validExitCodes
  silentArgs    = $silentArgs
  softwareName  = $softwareName
  checksum      = $checksum
  checksumType  = 'sha256' 
}

Install-ChocolateyPackage @packageArgs

