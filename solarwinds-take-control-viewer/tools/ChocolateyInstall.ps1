$ErrorActionPreference = 'Stop'
$packageName    = 'solarwinds-take-control-viewer'
$toolsDir       = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
$url            = 'https://rm-downloads-us.logicnow.com/MSP/TakeControlViewerInstall.exe'
$checksum       = '7A095B96984894FF9EA0A3DBD66FE11089083B1CC68558C08CE0D80017372590'

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
