$packageName    = 'performancetest'
$installerType  = 'exe'
$url            = 'https://www.passmark.com/ftp/petst.exe'
$checksum       = '15D2CD85CAFF83E31AF9A577AEE27B55695A3BC4FC96E2EAA3BEA22321D6BE2F'
$silentArgs     = '/VERYSILENT /SUPPRESSMSGBOXES /NORESTART /SP-'
$toolsDir       = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
$validExitCodes = @(0)
$softwareName   = 'PerformanceTest*'

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
