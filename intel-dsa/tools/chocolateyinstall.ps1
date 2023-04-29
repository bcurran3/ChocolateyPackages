$ErrorActionPreference = 'Stop'
$packageName = 'intel-dsa'
$url         = 'https://downloadmirror.intel.com/28425/Intel-Driver-and-Support-Assistant-Installer.exe'
#               ^^^^^^^^^ consistent dl link (only checksum of file changes)
$checksum    = 'EB5E791918B64C9C63AC862621AA0DD51152D904D1288310F696290E059C5C35'

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
