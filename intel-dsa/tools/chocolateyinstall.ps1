$packageName    = 'intel-dsa'
$url            = 'https://downloadmirror.intel.com/24345/a08/Intel%20Driver%20and%20Support%20Assistant%20Installer.exe'
$checksum       = '93687E65F064047170ECC0A0F5CFE336023F39AE298C9E12840D52BB384100AD'

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
