$packageName    = 'intel-xtu'
$installerType  = 'exe'
$url            = 'https://downloadmirror.intel.com/24075/eng/XTUSetup.exe'
$checksum       = '8491A42D134FBAD37B50D2EFA928977435D0437B576F386549CF4B8DAFE82E93'
$toolsDir       = $(Split-Path -parent $MyInvocation.MyCommand.Definition)
$silentArgs     = '/quiet /norestart'
$validExitCodes = @(0)


$packageArgs = @{
  packageName   = $packageName
  fileType      = $installerType
  url           = $url
  silentArgs    = $silentArgs
  validExitCodes= $validExitCodes
  softwareName  = 'Intel Extreme Tuning Utility'
  checksum      = $checksum
  checksumType  = 'sha256'
}
Show-Patreon "https://www.patreon.com/bcurran3"
Install-ChocolateyPackage @packageArgs
Show-ToastMessage "Home Assistant installed." "Version $env:packageVersion."
