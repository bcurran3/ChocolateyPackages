$packageName    = 'rdpguard'
$installerType  = 'exe'
$url            = 'https://rdpguard.com/download/rdpguard-4-2-5.exe'
$checksum       = 'C345C049E2EF79A817C3A875995A782EC1FE87BD891B770E3180FAB425DDFB11'
$silentArgs     = '/VERYSILENT /SUPPRESSMSGBOXES /NORESTART /SP-'
$toolsDir       = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
$validExitCodes = @(0)
$softwareName   = 'RdpGuard*'

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
