$packageName    = 'simple-sticky-notes'
$installerType  = 'exe'
$url            = 'http://www.simplestickynotes.com/setup/Setup_SimpleStickyNotes.exe'
$checksum       = '90ACD3F1568CB332DBB774B56C5C16166AF75C4D6DF42DF9A2FD3A515576845D'
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

