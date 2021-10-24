$packageName    = 'dual-monitor-tools'
$installerType  = 'msi'
$toolsDir       = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
$url            = 'https://downloads.sourceforge.net/project/dualmonitortool/dualmonitortool/2.8/DualMonitorTools-2.8.msi' 
$checksum       = '20AD9B4A8AEAC6474638A83F17EEC6483BCCFAD0CC0552FB3B695081C2AC658F'
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
  
