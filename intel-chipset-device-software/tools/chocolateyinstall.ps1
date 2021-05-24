$ErrorActionPreference = 'Stop'
$packageName    = 'intel-chipset-device-software'
$toolsDir       = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
$url            = 'https://downloadmirror.intel.com/30334/eng/SetupChipset.exe'
$checksum       = 'D4A1891CD83E19FBB3D908F6DB3BFD516F65E06108FBE0C45FB7FC52F132D3B4'

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
