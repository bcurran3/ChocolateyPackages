$packageName    = 'rdpguard'
$installerType  = 'exe'
$url            = 'https://rdpguard.com/download/rdpguard-5-3-5.exe'
$checksum       = '1DD5F6B2FB4DB57C45EC75900922EAF9FB65128F7D1B6CE10549F3388B60B45E'
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
