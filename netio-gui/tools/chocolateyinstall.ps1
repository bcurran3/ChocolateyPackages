$packageName    = 'io-gui'
$installerType  = 'exe'
$url            = 'https://downloads.sourceforge.net/project/netiogui/netio-gui_v1.0.4_setup.exe'
$checksum       = '9BD98871D1C000F4179F2561071C3B8A7AB7C49537C18ACF6CD65D296B40C1D8'
$silentArgs     = '/VERYSILENT /SUPPRESSMSGBOXES /NORESTART /SP-'
$toolsDir       = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
$validExitCodes = @(0)
$softwareName   = '1.0.2'

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
