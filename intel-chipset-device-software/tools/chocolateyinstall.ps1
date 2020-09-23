$ErrorActionPreference = 'Stop'
$packageName    = 'intel-chipset-device-software'
$toolsDir       = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
$url            = 'https://downloadmirror.intel.com/29634/eng/chipset-10.1.18383.8213-public-mup.zip'
$checksum       = '8756C6BB1AF5A1B403F55938C6AEAC1B642DCFE3DC5E4B15A225992D7A16546D'

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
  softwareName   = 'Intel(R) Chipset Device Software'
  fileType       = 'EXE'
  silentArgs     = '-s -norestart -log install.log'
  file           = "$toolsDir\unzipped\SetupChipset.exe"
  validExitCodes = @(0)
  }

Install-ChocolateyInstallPackage @packageArgs
Remove-Item "$toolsDir\unzipped" –Recurse | Out-Null