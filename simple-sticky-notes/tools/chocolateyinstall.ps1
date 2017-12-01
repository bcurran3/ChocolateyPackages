$packageName    = 'simple-sticky-notes'
$installerType  = 'exe'
$url            = 'http://www.simplestickynotes.com/setup/Setup_SimpleStickyNotes.exe'
$checksum       = 'E68B9E7AC095E264FE169D989920AD983841323B832A57B76A64A62E5D892244'
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

