$packageName   = 'logitech-options'
$toolsDir      = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
$installerType = 'exe'
$url           = 'https://download01.logi.com/web/ftp/pub/techsupport/options/Options_6.70.1197.exe'
$checksum      = '63FD5F943BBD338DB8F4868E0BDE2CE97742E46C23BB35F9FF83A6544272719C'
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

