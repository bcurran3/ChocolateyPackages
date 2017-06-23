$ErrorActionPreference = 'Stop'
$packageName   = 'vmware-tools'
$installerType = 'exe'
$toolsDir      = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
$url           = 'https://packages.vmware.com/tools/esx/6.0/windows/x86/VMware-tools-9.10.0-2476743-i386.exe' 
$checksum      = 'B3F40BB3C9B40EE10585934E5CC58FAD49A58C717AA3DB21C0448FECAFDFDEC8'
$url64         = 'https://packages.vmware.com/tools/esx/6.0/windows/x64/VMware-tools-9.10.0-2476743-x86_64.exe' 
$checksum64    = 'EA099AE2046D6522FD337E4C08E96EF57B4B9C8DA848DB6CA83A19F912EBC73B'
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
  
