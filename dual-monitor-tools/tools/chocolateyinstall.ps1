$packageName    = 'dual-monitor-tools'
$installerType  = 'msi'
$toolsDir       = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
$url            = 'https://sourceforge.net/projects/dualmonitortool/files/dualmonitortool/2.6/DualMonitorTools-2.6.msi' 
$checksum       = '69DBF3959ADD36AFF442C96836690A943721F92CD1A262D6A97F2901BE212000'
$silentArgs     = '/quiet /qn /norestart'
$validExitCodes = @(0, 3010, 1641)

$packageArgs = @{
  packageName   = $packageName
  fileType      = $installerType
  url           = $url
  validExitCodes= $validExitCodes
  silentArgs    = $silentArgs
  softwareName  = 'Dual Monitor Tools'
  checksum      = $checksum
  checksumType  = 'sha256' 
}

Install-ChocolateyPackage @packageArgs  
  
