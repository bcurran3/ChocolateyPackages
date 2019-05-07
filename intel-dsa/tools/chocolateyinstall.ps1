$ErrorActionPreference = 'Stop'
$packageName    = 'intel-dsa'
$url            = 'https://downloadmirror.intel.com/28425/a08/Intel%20Driver%20and%20Support%20Assistant%20Installer.exe'
$checksum       = 'D59C0A8744A8AA8D61DAF5FC3E345934BB17EC1FFDA0FA55BEF21B7476696A13'

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
