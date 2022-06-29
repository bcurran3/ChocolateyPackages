$ErrorActionPreference = 'Stop'
$packageName = 'intel-dsa'
$url         = 'https://downloadmirror.intel.com/28425/Intel-Driver-and-Support-Assistant-Installer.exe'
#               ^^^^^^^^^ consistent dl link (only checksum of file changes)
$checksum    = 'E40F49627B6FDA7DF147AC42DCAF42BFFCB6C7AB1E42CD133AB64BC0DC7737B6'

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
