$packageName= 'drivermax' 
$toolsDir   = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
$url        = 'http://www.drivermax.com/soft/dmx/drivermax.exe'
$checksum   = 'B9115C6E8994FCBE908FC559F4E4228B93E6D38F8CCD2BC5BDA424D0B5B68150'

$packageArgs = @{
  packageName   = $packageName
  unzipLocation = $toolsDir
  fileType      = 'exe' 
  url           = $url
  silentArgs   = '/SP- /VERYSILENT /SUPPRESSMSGBOXES /CLOSEAPPLICATIONS' 
  softwareName  = 'DriverMax*' 
  checksum      = $checksum
  checksumType  = 'sha256'
  }
  
Install-ChocolateyPackage @packageArgs

