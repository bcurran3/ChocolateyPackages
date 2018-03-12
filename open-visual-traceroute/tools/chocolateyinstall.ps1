$packageName = 'open-visual-traceroute' 
$toolsDir    = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
$url         = 'https://downloads.sourceforge.net/project/openvisualtrace/1.7.0/OpenVisualTraceroute1.7.0.exe'
$checksum    = '89D389CF5A83FA71BD269CCC01436277D2C9ADD5039D7A5657F4A1FB377B7FCA'
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

