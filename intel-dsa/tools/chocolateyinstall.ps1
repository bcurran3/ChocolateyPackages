$ErrorActionPreference = 'Stop'
$packageName    = 'intel-dsa'
$url            = 'https://downloadmirror.intel.com/28425/eng/Intel%20Driver%20and%20Support%20Assistant%20Installer.exe'
$checksum       = '89ED8DDE25EE0BBA9805DCD6DF9CF4B22CC0B34DFC6D1C2ABBF6B7689028ACD5'

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
