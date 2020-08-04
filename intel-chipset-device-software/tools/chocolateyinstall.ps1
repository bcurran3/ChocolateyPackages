$ErrorActionPreference = 'Stop'
$packageName    = 'intel-chipset-device-software'
$installerType  = 'exe'
$toolsDir       = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
$url            = 'https://downloadmirror.intel.com/29227/eng/chipset-10.1.18228.8176-public-mup.zip'
$checksum       = '32E84117C4A97E7029B20BCE431941F09D63CEED98E7C873A7AA18AB3370F908'
$silentArgs     = '-s -norestart'
$validExitCodes = @(0)

$packageArgs = @{
  packageName    = $packageName
  unzipLocation  = "$toolsDir\unzipped"
  fileType       = 'ZIP' 
  url            = $url
  checksum       = $checksum
  checksumType   = 'sha256'
}

Install-ChocolateyZipPackage @packageArgs

$packageArgs = @{
  packageName    = $packageName
  softwareName   = 'Intel® Chipset Device Software'
  fileType       = 'EXE'
  silentArgs     = '-s -norestart'
  file           = "$toolsDir\unzipped\SetupChipset.exe"
  validExitCodes = @(0)
  }

Install-ChocolateyInstallPackage @packageArgs
