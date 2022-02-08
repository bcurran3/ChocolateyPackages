$ErrorActionPreference = 'Stop'
$packageName    = 'intel-chipset-device-software'
$toolsDir       = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
$url            = 'https://downloadmirror.intel.com/30553/eng/setupchipset.exe'
#                                                   ^^^^^ changes 
$checksum       = 'DEAB9FC03112350552E8CB2C15713670220764035BE8BEAC4789FBE73594EA32'

$packageArgs = @{
  packageName    = $packageName
  fileType       = 'EXE'
  url            = $url
  validExitCodes = @(0,1,3010)
  silentArgs     = '-s -norestart -downgrade'
  softwareName   = 'Intel(R) Chipset Device Software'
  checksum       = $checksum
  checksumType   = 'sha256' 
}

Install-ChocolateyPackage @packageArgs
