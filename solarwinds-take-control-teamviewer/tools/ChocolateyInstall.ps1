$packageName    = 'solarwinds-take-control-teamviewer'
$toolsDir       = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
$url            = 'https://dashboard.systemmonitor.us/rap.php?Action=downloadtcviewerteamviewer'
$checksum       = '9CAD9B6A239992DD3463A4F6809BED06617FA796EF61F1D7499E3CF4038606E6'

$packageArgs = @{
  packageName    = $packageName
  fileType       = 'EXE'
  url            = $url
  validExitCodes = @(0,1)
  silentArgs     = '/VERYSILENT /SUPPRESSMSGBOXES /NORESTART /SP-'
  softwareName   = 'TeamViewer 13'
  checksum       = $checksum
  checksumType   = 'sha256'
}

Install-ChocolateyPackage @packageArgs
