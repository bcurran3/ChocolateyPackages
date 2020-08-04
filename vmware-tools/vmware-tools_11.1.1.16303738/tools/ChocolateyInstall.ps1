# https://packages.vmware.com/tools/releases

$ErrorActionPreference = 'Stop'
$packageName       = 'vmware-tools'
$toolsDir          = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
$url               = 'https://packages.vmware.com/tools/releases/11.1.1/windows/x86/VMware-tools-11.1.1-16303738-i386.exe'
$checksum          = '50FEB3EBAD7C0EEA199AE08F961F23816F2C272829D5E69981E8ABA5566D932E'
$url64             = 'https://packages.vmware.com/tools/releases/11.1.1/windows/x64/VMware-tools-11.1.1-16303738-x86_64.exe'
$checksum64        = '77254339C1A6DB0EC550BF814542ED6D88921E8771219724DC145DAB38BD8F37'

$packageArgs = @{
  packageName    = $packageName
  fileType       = 'EXE'
  url            = $url
  url64bit       = $url64
  validExitCodes = @(0)
  silentArgs     = '/S /v /qn REBOOT=R'
  softwareName   = 'VMware Tools'
  checksum       = $checksum 
  checksumType   = 'sha256' 
  checksum64     = $checksum64
  checksumType64 = 'sha256'
}

Install-ChocolateyPackage @packageArgs  
