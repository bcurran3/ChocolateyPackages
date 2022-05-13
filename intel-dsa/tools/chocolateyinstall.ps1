$ErrorActionPreference = 'Stop'
$packageName = 'intel-dsa'
$url         = 'https://downloadmirror.intel.com/28425/Intel-Driver-and-Support-Assistant-Installer.exe'
#               ^^^^^^^^^ consistent dl link (only checksum of file changes)
$checksum    = '9FEA80E87111970D1A0B9EA92C8DAA43808C3D75A8C3BE3544B9BA81F969BF68'

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
