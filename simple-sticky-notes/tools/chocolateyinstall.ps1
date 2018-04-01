$packageName    = 'simple-sticky-notes'
$installerType  = 'exe'
$url            = 'http://www.simplestickynotes.com/setup/Setup_SimpleStickyNotes.exe'
$checksum       = '4F8DD1B3564FB6B7E0F213D1D09F565A7B607888FED678306834C80728EE1E88'
$silentArgs     = '/VERYSILENT /SUPPRESSMSGBOXES /NORESTART /SP-'
$toolsDir       = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
$validExitCodes = @(0,1)
$softwareName   = 'Simple Sticky Notes*'

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

