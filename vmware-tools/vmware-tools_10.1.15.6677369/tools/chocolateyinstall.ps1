$ErrorActionPreference = 'Stop'
$packageName   = 'vmware-tools'
$installerType = 'exe'
$toolsDir      = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
$url           = 'https://packages.vmware.com/tools/releases/10.1.15/windows/x86/VMware-tools-10.1.15-6677369-i386.exe' 
$checksum      = '7E3355C387E312741D86B409170A6A174D0E75F019FE39CC6C32D11C5C3821E7'
$url64         = 'https://packages.vmware.com/tools/releases/10.1.15/windows/x64/VMware-tools-10.1.15-6677369-x86_64.exe' 
$checksum64    = '81139F8391FA74ED987244B04943D3E9E678951C63A36A01B97C8FEB1A0CB842'
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
  
