$ErrorActionPreference = 'Stop'
$packageName    = 'intel-dsa'
$url            = 'https://downloadmirror.intel.com/28425/a08/Intel%20Driver%20and%20Support%20Assistant%20Installer.exe'
$checksum       = '57510792AB273FF74464FEDB101CE2FC3350160EA476313E0E6650075DECBA11'

$packageArgs = @{
  packageName    = $packageName
  fileType       = 'EXE'
  url            = $url
  silentArgs     = '-s -norestart'
  validExitCodes = @(0)
  softwareName   = 'Intel® Driver & Support Assistant'
  checksum       = $checksum
  checksumType   = 'sha256'
}

Start-WaitandStop "SurConsent"
Install-ChocolateyPackage @packageArgs
