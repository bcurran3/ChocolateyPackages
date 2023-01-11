$ErrorActionPreference = 'Stop'
$packageName = 'intel-dsa'
$url         = 'https://downloadmirror.intel.com/28425/Intel-Driver-and-Support-Assistant-Installer.exe'
#               ^^^^^^^^^ consistent dl link (only checksum of file changes)
$checksum    = 'E2E86BE8C07A3BE5708659C2BBE6B75209876B37E145D43AD28530AD98BEC50A'

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
