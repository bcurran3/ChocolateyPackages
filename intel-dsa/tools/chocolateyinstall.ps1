$ErrorActionPreference = 'Stop'
$packageName    = 'intel-dsa'
$url            = 'https://downloadmirror.intel.com/28425/a08/Intel-Driver-and-Support-Assistant-Installer.exe'
$checksum       = '59A98CB7B659B8C01651201E385355DA257F1149963A850BE3B1612913D2E5E9'

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
