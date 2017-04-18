$packageName   = 'logitech-options'
$toolsDir      = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
$installerType = 'exe'
$url           = 'https://download01.logi.com/web/ftp/pub/techsupport/options/Options_6.50.60.exe'
$checksum      = 'C25506BAFEB00AB96E362C468BF263D5E419A02F80A593A190DDA78815495513'
$silentArgs    = '/S'

$packageArgs = @{
  packageName   = $packageName
  unzipLocation = $toolsDir
  fileType      = $installerType
  url           = $url
  silentArgs    = $silentArgs
  softwareName  = 'Logitech Options' 
  checksum      = $checksum
  checksumType  = 'sha256'  
  }
Install-ChocolateyPackage @packageArgs

