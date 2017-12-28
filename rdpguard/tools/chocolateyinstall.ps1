$packageName    = 'rdpguard'
$installerType  = 'exe'
$url            = 'https://rdpguard.com/download/rdpguard-4-8-9.exe'
$checksum       = 'A32A76F268B273C0B25A0E6FD2235DED69FF15E04BA00310450949D2228CB35A'
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
