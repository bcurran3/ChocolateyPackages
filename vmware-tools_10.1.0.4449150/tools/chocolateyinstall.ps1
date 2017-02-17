$ErrorActionPreference = 'Stop'
$packageName   = 'vmware-tools'
$installerType = 'exe'
$toolsDir      = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
$url           = 'https://packages.vmware.com/tools/esx/6.5/windows/x86/VMware-tools-10.1.0-4449150-i386.exe' 
$checksum      = 'DE5ABD8A112DED66821988C17B14E3FEABF850DD510226C4FBAE0087021B533A'
$url64         = 'https://packages.vmware.com/tools/esx/6.5/windows/x64/VMware-tools-10.1.0-4449150-x86_64.exe' 
$checksum64    = '7A3A9F5183B179DF9D0AF3B6DDCBA69AFAC83252DA58CA8ECD6311DAC2DE8727'
$silentArgs    = '/S /v /qn'
$validExitCodes= @(0)

$packageArgs = @{
  packageName   = $packageName
  fileType      = $installerType
  url           = $url
  url64bit      = $url64
  validExitCodes= $validExitCodes
  silentArgs    = $silentArgs
  softwareName  = 'VMware Tools'
  checksum      = $checksum 
  checksumType  = 'sha256' 
  checksum64    = $checksum64
  checksumType64= 'sha256'
}

Install-ChocolateyPackage @packageArgs  
  
