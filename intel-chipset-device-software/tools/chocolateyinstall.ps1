$packageName    = 'intel-chipset-device-software'
$installerType  = 'exe'
$toolsDir       = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
$url            = 'https://downloadmirror.intel.com/20775/eng/SetupChipset.exe'
$checksum       = '38710F89F716326AB0A83DE17270B70F4D96452DC0B34B654EA1B29B5B17BAB7'
$silentArgs     = '-s -norestart'
$validExitCodes = @(0)

$packageArgs = @{
  packageName   = $packageName
  fileType      = $installerType
  url           = $url
  validExitCodes= $validExitCodes
  silentArgs    = $silentArgs
  softwareName  = 'Intel® Chipset Device Software*'
  checksum      = $checksum
  checksumType  = 'sha256' 
}

Install-ChocolateyPackage @packageArgs  
  
