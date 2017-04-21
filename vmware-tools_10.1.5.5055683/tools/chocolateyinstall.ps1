$ErrorActionPreference = 'Stop'
$packageName   = 'vmware-tools'
$installerType = 'exe'
$toolsDir      = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
$url           = 'https://packages.vmware.com/tools/releases/10.1.5/windows/x86/VMware-tools-10.1.5-5055683-i386.exe' 
$checksum      = '6DDBC056EBCC58C01D93B960D14B5688661C8AE601459BA5A8C6145DF441A75A'
$url64         = 'https://packages.vmware.com/tools/releases/10.1.5/windows/x64/VMware-tools-10.1.5-5055683-x86_64.exe' 
$checksum64    = '82D911B26E4A759F89DAC5C0BAED7062BBC8705BDB23FBCC7F694D4E51F9D570'
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
  
