$ErrorActionPreference = 'Stop'
$packageName = 'intel-dsa'
$url         = 'https://downloadmirror.intel.com/28425/a08/Intel-Driver-and-Support-Assistant-Installer.exe'
$checksum    = 'C:\Program Files (x86)\Advanced Monitoring Agent\featureres'

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
