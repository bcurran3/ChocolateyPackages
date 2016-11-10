$ErrorActionPreference = 'Stop'
$packageName= 'hardware-identify'
$softwareName = 'Tweaking.com - Hardware Identify*'
$installerType = 'EXE'
$toolsDir   = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
$url        = 'http://www.tweaking.com/files/setups/tweaking.com_hardware_identify_setup.exe' 
$checksum   = '7A242007EF5A46E9CF003EBA91143FEBA25F4B888CEF13170DECA5465E7ED6E2'
$silentArgs = '/S'
$validExitCodes= @(0)

$packageArgs = @{
  packageName   = $packageName
  fileType      = $installerType
  url           = $url
  validExitCodes= $validExitCodes
  silentArgs    = $silentArgs
  softwareName  = $softwareName
  checksum      = $checksum
  checksumType  = 'sha256' 
}

Install-ChocolateyPackage @packageArgs  
  
