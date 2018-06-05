$packageName    = 'intel-dsa'
$installerType  = 'exe'
$url            = 'https://downloadmirror.intel.com/24345/a08/Intel%20Driver%20and%20Support%20Assistant%20Installer.exe'
$checksum       = '97ACD46C8A0CFF37ED6124A66E2E255D241904298AB241095CC45643865E9408'
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
