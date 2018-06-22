$packageName    = 'vhdattach'
$installerType  = 'exe'
$url            = 'https://www.medo64.com/download/vhdattach420.exe'
$checksum       = 'C84FFE04B19D477DDFA645D5AEC9100C21F4363417B7EC933E4A7F7560CF38F8'
$silentArgs     = '/VERYSILENT /SUPPRESSMSGBOXES /NORESTART /SP-'
$toolsDir       = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
$validExitCodes = @(0,1)
$softwareName   = 'VHD Attach*'

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

