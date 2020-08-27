$ErrorActionPreference = 'Stop'
$packageName    = 'solarwinds-take-control-viewer'
$toolsDir       = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
$url            = 'https://dashboard.systemmonitor.us/rap.php?Action=downloadtcviewermspanywherewin'
$checksum       = '8BEF2276E0CF30C1D4D59943171E84C1A153BDE00F88C3E645D9F6537F96BC44'

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
