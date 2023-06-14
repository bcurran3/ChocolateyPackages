$ErrorActionPreference = 'Stop'
$packageName    = 'solarwinds-take-control-viewer'
$toolsDir       = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
$url            = 'https://swi-rc.cdn-sw.net/logicnow/Updates/7.00.47/TakeControlViewerInstall-7.00.47-20230601.exe'
$checksum       = '623ED40C2670B017B3C508900A5A008D254BD9C353AC067CF2FFC530A5F4997E'

$packageArgs = @{
  packageName    = $packageName
  fileType       = 'EXE'
  url            = $url
  validExitCodes = @(0,1)
  silentArgs     = '/S'
  softwareName   = 'Take Control Viewer'
  checksum       = $checksum
  checksumType   = 'sha256'
}

Install-ChocolateyPackage @packageArgs

Start-CheckandStop "TakeControlRDLdr"
Start-CheckandStop "TakeControlRDViewer"
