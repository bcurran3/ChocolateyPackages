$ErrorActionPreference = 'Stop'
$packageName   = 'vmware-tools'
$installerType = 'exe'
$toolsDir      = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
$url           = 'https://packages.vmware.com/tools/esx/5.5u2/windows/x86/VMware-tools-9.4.10-2068191-i386.exe' 
$checksum      = '72AA997C89E377D961E40B291F39F52880E16932A909117BA1A490C0014658E0'
$url64         = 'https://packages.vmware.com/tools/esx/5.5u2/windows/x64/VMware-tools-9.4.10-2068191-x86_64.exe' 
$checksum64    = 'F533F44FC4F03D872F428114A451ADD35D1BAB3E7D446C96F2407F2DE9A43BA6'
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
  
