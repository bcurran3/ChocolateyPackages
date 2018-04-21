$packageName    = 'drivermax' 
$toolsDir       = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
$url            = 'https://www.drivermax.com/soft/dmx/drivermax.exe'
$checksum       = '8CB4E3525ED006F80F34A1418E3BC5C556AA09B84714AF09C732BE143668D17C'
$validExitCodes = @(0, 1)

$packageArgs = @{
  packageName   = $packageName
  unzipLocation = $toolsDir
  fileType      = 'exe' 
  url           = $url
  validExitCodes= $validExitCodes  
  silentArgs    = '/SP- /VERYSILENT /SUPPRESSMSGBOXES /CLOSEAPPLICATIONS' 
  softwareName  = 'DriverMax*' 
  checksum      = $checksum
  checksumType  = 'sha256'
  }
  
Install-ChocolateyPackage @packageArgs

