$packageName    = 'simple-sticky-notes'
$installerType  = 'exe'
$url            = 'http://www.simplestickynotes.com/setup/Setup_SimpleStickyNotes.exe'
$checksum       = '86FAA7DEF6A6C7677C5AB36C9446A26593EE5FAC3B32239101751F2A30DAFD79'
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

