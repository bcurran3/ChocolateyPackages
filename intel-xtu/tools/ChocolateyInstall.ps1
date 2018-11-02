$packageName    = 'intel-xtu'
$toolsDir       = $(Split-Path -parent $MyInvocation.MyCommand.Definition)
$url            = 'https://downloadmirror.intel.com/24075/eng/XTUSetup.exe'
$checksum       = '236F39F4B4F8ED1C48C4A2C2CB72198933C65132A0FA4314ACD51BE4D5B08445'

$packageArgs = @{
  packageName   = $packageName
  fileType      = 'EXE'
  url           = $url
  silentArgs    = '/quiet /norestart'
  validExitCodes= @(0, 3010)
  softwareName  = 'Intel Extreme Tuning Utility'
  checksum      = $checksum
  checksumType  = 'sha256'
}

Install-ChocolateyPackage @packageArgs
