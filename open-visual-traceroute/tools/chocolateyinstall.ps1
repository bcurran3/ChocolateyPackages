$packageName = 'open-visual-traceroute' 
$toolsDir    = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
$url         = 'http://pilotfiber.dl.sourceforge.net/project/openvisualtrace/1.6.4/OpenVisualTraceroute1.6.4.exe'
$checksum    = '1E53BF068D947C628AA92344CCD3B1BDAF8BCE57CDECCC3FD2D2881B436E892A'
$ahkExe         = 'AutoHotKey'
$ahkFile        = Join-Path $toolsDir "OVTInstall.ahk"

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

