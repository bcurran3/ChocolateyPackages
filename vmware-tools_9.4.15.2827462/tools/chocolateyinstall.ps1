$ErrorActionPreference = 'Stop'
$packageName   = 'vmware-tools'
$installerType = 'exe'
$toolsDir      = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
$url           = 'https://packages.vmware.com/tools/esx/5.5u3/windows/x86/VMware-tools-9.4.15-2827462-i386.exe' 
$checksum      = '2D255C5A8BD87D72A45B0F7144096360D618769193FAEAE6216F48C2BEADE78F'
$url64         = 'https://packages.vmware.com/tools/esx/5.5u3/windows/x64/VMware-tools-9.4.15-2827462-x86_64.exe' 
$checksum64    = '80203AAEF99EA5DF1977C21178BB581E8D3AA7266CD560353B0C93E65A6CD36F'
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
  
