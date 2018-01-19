$ErrorActionPreference = 'Stop'
$packageName   = 'vmware-tools'
$installerType = 'exe'
$toolsDir      = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
$url           = 'https://packages.vmware.com/tools/releases/10.1.10/windows/x86/VMware-tools-10.1.10-6082533-i386.exe' 
$checksum      = '0DAFC779E7C48AF6DD42FFEC50B68F0001D35695A2127D9FB00825EEECAD4A19'
$url64         = 'https://packages.vmware.com/tools/releases/10.1.10/windows/x64/VMware-tools-10.1.10-6082533-x86_64.exe' 
$checksum64    = '3121C4FE568735AD29BF929480E3766C79BA02E7A11A28EEB11248219A7FC67E'
$silentArgs    = '/S /v /qn REBOOT=R '
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
  
