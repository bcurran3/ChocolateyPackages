$packageName    = 'intel-dsa'
$installerType  = 'exe'
$url            = 'https://downloadmirror.intel.com/24345/a08/Intel%20Driver%20and%20Support%20Assistant%20Installer.exe'
$checksum       = 'DF6B51AD6C494E53BCEB7958650FF8ED7DC106324EC6F507381EB4494F0974AD'
$toolsDir       = $(Split-Path -parent $MyInvocation.MyCommand.Definition)
$silentArgs     = '-s -norestart'
$validExitCodes = @(0)

Start-WaitandStop "SurConsent"

$packageArgs = @{
  packageName   = $packageName
  fileType      = $installerType
  url           = $url
  silentArgs    = $silentArgs
  validExitCodes= $validExitCodes
  softwareName  = 'Intel® Driver & Support Assistant'
  checksum      = $checksum
  checksumType  = 'sha256'
}

Install-ChocolateyPackage @packageArgs
