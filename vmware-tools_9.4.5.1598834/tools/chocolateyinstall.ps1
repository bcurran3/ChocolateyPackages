$ErrorActionPreference = 'Stop'
$packageName   = 'vmware-tools'
$installerType = 'exe'
$toolsDir      = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
$url           = 'https://packages.vmware.com/tools/esx/5.5u1/windows/x86/VMware-tools-9.4.5-1598834-i386.exe' 
$checksum      = '8E8D3D955F7B2EA495549741BCBD4BB6DC7CCB21F01411164D21C31D96AC7097'
$url64         = 'https://packages.vmware.com/tools/esx/5.5u1/windows/x64/VMware-tools-9.4.5-1598834-x86_64.exe' 
$checksum64    = 'D948637CB6A2433C2ED68D898E4EC1BDAC9528FE2D0B7ABC9CC8B89BBCFEBF40'
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
  
