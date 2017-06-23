$ErrorActionPreference = 'Stop'
$packageName   = 'vmware-tools'
$installerType = 'exe'
$toolsDir      = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
$url           = 'https://packages.vmware.com/tools/esx/6.0u2/windows/x86/VMware-tools-10.0.6-3560309-i386.exe'
$checksum      = 'CA4012A3D6F2F296C0CDBD8E6B2D2589F54312869F5AA722546EF702F312F033'
$url64         = 'https://packages.vmware.com/tools/esx/6.0u2/windows/x64/VMware-tools-10.0.6-3560309-x86_64.exe' 
$checksum64    = '677C131FA6D1A1E9F3645B7529B2C1DBCF3C4F5638B6B1A6D8E4D16BE4475955'
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
  