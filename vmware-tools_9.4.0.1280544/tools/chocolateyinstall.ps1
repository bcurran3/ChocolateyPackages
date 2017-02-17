$ErrorActionPreference = 'Stop'
$packageName   = 'vmware-tools'
$installerType = 'exe'
$toolsDir      = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
$url           = 'https://packages.vmware.com/tools/esx/5.5/windows/x86/VMware-tools-9.4.0-1280544-i386.exe' 
$checksum      = 'D73B3116C6591F19CB1C2C27DCA1D13A5AF3D4BC744BB7ECE574BC26E2E5BBF2'
$url64         = 'https://packages.vmware.com/tools/esx/5.5/windows/x64/VMware-tools-9.4.0-1280544-x86_64.exe' 
$checksum64    = '80DC894066DF6B1776CDB77BF14647DBAADEC71B9A16E01BC0D16C3D06F619EA'
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
  
