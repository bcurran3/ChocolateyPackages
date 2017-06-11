$ErrorActionPreference = 'Stop'
$packageName   = 'vmware-tools'
$installerType = 'exe'
$toolsDir      = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
$url           = 'https://packages.vmware.com/tools/releases/10.1.7/windows/x86/VMware-tools-10.1.7-5541682-i386.exe' 
$checksum      = 'B6FBD8F979E1B6607D93938BBDAD61BA90474E6052D2696077AC4F81555E5115'
$url64         = 'https://packages.vmware.com/tools/releases/10.1.7/windows/x64/VMware-tools-10.1.7-5541682-x86_64.exe' 
$checksum64    = 'ABB20617DE91F780D12B2E628965336BE8CDE784317980E4C154E3DF555191C9'
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
  
