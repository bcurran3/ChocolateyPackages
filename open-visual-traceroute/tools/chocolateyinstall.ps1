$packageName= 'open-visual-traceroute' 
$toolsDir   = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
$url        = 'http://pilotfiber.dl.sourceforge.net/project/openvisualtrace/1.6.4/OpenVisualTraceroute1.6.4.exe'
$checksum   = '00D8F43D7A4651ECCBEBDB503C79B5685F0CC34DDEC4F7F26DFCAE6AA6C872A8'

$packageArgs = @{
  packageName   = $packageName
  unzipLocation = $toolsDir
  fileType      = 'exe' 
  url           = $url
  silentArgs   = '/VERYSILENT /SUPPRESSMSGBOXES /NORESTART /SP-' 
  softwareName  = 'Open Visual Traceroute*' 
  checksum      = $checksum
  checksumType  = 'sha256'
  }
Install-ChocolateyPackage @packageArgs

