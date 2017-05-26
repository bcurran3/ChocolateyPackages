$packageName = 'open-visual-traceroute' 
$toolsDir    = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
$url         = 'https://downloads.sourceforge.net/project/openvisualtrace/1.6.5/OpenVisualTraceroute1.6.5.exe'
$checksum    = '414D1CF8355D7D5934618092BBCC278F9363F515F2718D5514B0E5C2423BBECA'
$ahkExe      = 'AutoHotKey'
$ahkFile     = Join-Path $toolsDir "OVTInstall.ahk"

Start-Process $ahkExe $ahkFile

$packageArgs = @{
  packageName   = $packageName
  unzipLocation = $toolsDir
  fileType      = 'exe' 
  url           = $url
  silentArgs    = '/VERYSILENT /SUPPRESSMSGBOXES /NORESTART /SP-' 
  softwareName  = 'Open Visual Traceroute*' 
  checksum      = $checksum
  checksumType  = 'sha256'
  }
Install-ChocolateyPackage @packageArgs

