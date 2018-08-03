$toolsDir       = $(Split-Path -parent $MyInvocation.MyCommand.Definition)
$packageName    = 'intel-dsa'
$url            = 'https://downloadmirror.intel.com/24345/a08/Intel%20Driver%20and%20Support%20Assistant%20Installer.exe'
$checksum       = 'BFE7468612C9E2B7CB08B9CA39E269AD376D8DD545B742EAAB31319A8DA73ABA'

$packageArgs = @{
  packageName   = $packageName
  fileType      = 'exe'
  url           = $url
  silentArgs    = '-s -norestart'
  validExitCodes= @(0)
  softwareName  = 'Intel® Driver & Support Assistant'
  checksum      = $checksum
  checksumType  = 'sha256'
}

Start-WaitandStop "SurConsent"
Install-ChocolateyPackage @packageArgs
