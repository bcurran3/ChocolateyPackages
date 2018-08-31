$packageName = 'open-visual-traceroute' 
$toolsDir    = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
$url         = 'https://downloads.sourceforge.net/project/openvisualtrace/1.7.1/OpenVisualTraceroute1.7.1.exe'
$checksum    = '7BC73FC835E7C89D885914F79C6465B3821CB56010AA8FD97E59C4DA67D10BD1'
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

