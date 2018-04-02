$packageName    = 'getdataback-simple'
$installerType  = 'exe'
$url            = 'https://www.runtime.org/gdbsimsetup.exe'
$checksum       = '54836F889CF154CDCC98CE7F2DEB39D3F87E6E479BFFB01F21C1479AB0203B81'
$silentArgs     = '/VERYSILENT /SUPPRESSMSGBOXES /NORESTART /SP-'
$toolsDir       = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
$validExitCodes = @(0)
$softwareName   = 'GetDataBack Simple*'

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
