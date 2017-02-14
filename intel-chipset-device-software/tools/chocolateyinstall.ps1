$packageName    = 'intel-chipset-device-software'
$installerType  = 'exe'
$toolsDir       = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
$url            = 'https://downloadmirror.intel.com/20775/eng/SetupChipset.exe'
$silentArgs     = '-s -norestart'
$validExitCodes = @(0)

$packageArgs = @{
  packageName   = $packageName
  fileType      = $installerType
  url           = $url
  validExitCodes= $validExitCodes
  silentArgs    = $silentArgs
  softwareName  = 'Intel® Chipset Device Software*'
  checksum      = '448D553D67A4F85A2D41D2D60FC6BD19ABA9ACA0505CF674D3C0AF55ED780690'
  checksumType  = 'sha256' 
}

Install-ChocolateyPackage @packageArgs  
  
