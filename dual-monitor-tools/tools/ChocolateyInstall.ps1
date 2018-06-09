$packageName    = 'dual-monitor-tools'
$installerType  = 'msi'
$toolsDir       = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
$url            = 'https://sourceforge.net/projects/dualmonitortool/files/dualmonitortool/2.7/DualMonitorTools-2.7.msi' 
$checksum       = 'EFE4130EF57407712A7B71B99780ED7268D51C027678DCE2AAFFAEB78FF0A722'
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
  
