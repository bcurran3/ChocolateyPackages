$ErrorActionPreference = 'Stop'
$packageName    = 'solarwinds-take-control-viewer'
$toolsDir       = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
$url            = 'https://dashboard.systemmonitor.us/rap.php?Action=downloadtcviewermspanywherewin'
$checksum       = '5F72A350F929D499F75DF9B1D2C852F6019A59A74C9651B17F84993BCC2F9285'

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
