$ErrorActionPreference = 'Stop'
$packageName = 'intel-dsa'
$url         = 'https://downloadmirror.intel.com/28425/Intel-Driver-and-Support-Assistant-Installer.exe'
$checksum    = '184ED335D5D1B604DB03B5A3DB6E96B2D4041D8C7EFB0C9E5B9A8B5DCA213969'

$packageArgs = @{
  packageName    = $packageName
  fileType       = 'EXE'
  url            = $url
  silentArgs     = '-s -norestart'
  validExitCodes = @(0, 3010, 1641)
  softwareName   = 'Intel® Driver & Support Assistant'
  checksum       = $checksum
  checksumType   = 'sha256'
}

Start-WaitandStop "SurConsent"
Install-ChocolateyPackage @packageArgs

# UPDATE INSTRUCTIONS:
# Update checksum as the dl link is constant
