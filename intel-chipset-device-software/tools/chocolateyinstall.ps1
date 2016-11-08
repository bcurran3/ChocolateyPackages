$packageName= 'intel-chipset-device-software'
$installerType = 'exe'
$toolsDir   = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
$url = 'https://downloadmirror.intel.com/20775/eng/SetupChipset.exe'
$silentArgs = '-s -norestart'
$validExitCodes= @(0)

$packageArgs = @{
  packageName   = $packageName
  fileType      = $installerType
  url           = $url
  validExitCodes= $validExitCodes
  silentArgs    = $silentArgs
  softwareName  = 'Intel® Chipset Device Software*'
  checksum      = '151276B51604C8616D2C214B2C00DAB69961B0826E31E78FDB0392A21A112AFC'
  checksumType  = 'sha256' 
}

Install-ChocolateyPackage @packageArgs  
  
