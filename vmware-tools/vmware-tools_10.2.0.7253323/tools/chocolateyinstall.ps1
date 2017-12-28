$ErrorActionPreference = 'Stop'
$packageName   = 'vmware-tools'
$installerType = 'exe'
$toolsDir      = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
$url           = 'https://packages.vmware.com/tools/releases/10.2.0/windows/x86/VMware-tools-10.2.0-7253323-i386.exe'
$checksum      = '4667DB25A7CD1FEBDAECC5299B6AF2BBD4EB34AB5A8E0F24BAED4B61962EA692'
$url64         = 'https://packages.vmware.com/tools/releases/10.2.0/windows/x64/VMware-tools-10.2.0-7253323-x86_64.exe'
$checksum64    = '7E5DD92264C7240C693767A3F827DD6AD61C49E0B1504AEB80B77857D8AB1A32'
$silentArgs    = '/S /v /qn REBOOT=R'
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
  
