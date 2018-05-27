$packageName    = 'performancetest'
$installerType  = 'exe'
$url            = 'https://www.passmark.com/ftp/petst.exe'
$checksum       = 'BBFB366274ADC911AAD719E91F27CAB8310344C275A0E0BE2135DE08DD0E4413'
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
