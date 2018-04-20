$ErrorActionPreference = 'Stop'
$packageName   = 'vmware-tools'
$installerType = 'exe'
$toolsDir      = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
$url           = 'https://packages.vmware.com/tools/releases/10.2.5/windows/x86/VMware-tools-10.2.5-8068406-i386.exe'
$checksum      = 'DBA110FB43230BAA827BD5E2EAEBD599CC6487BE361D3DBA6E550523440F3E46'
$url64         = 'https://packages.vmware.com/tools/releases/10.2.5/windows/x64/VMware-tools-10.2.5-8068406-x86_64.exe'
$checksum64    = '35B682CB120B7B2707708A6785BFCA9A7D53A2C4563C8C9E1B7C235E3A42CDFE'
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
  
