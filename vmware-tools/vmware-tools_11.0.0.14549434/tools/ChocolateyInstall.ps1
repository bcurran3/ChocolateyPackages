$ErrorActionPreference = 'Stop'
$packageName       = 'vmware-tools'
$toolsDir          = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
$url               = 'https://packages.vmware.com/tools/releases/11.0.0/windows/x86/VMware-tools-11.0.0-14549434-i386.exe'
$checksum          = 'D0D93A857E7AADDACD048A08D1F54B608D232E2DFB998D9123458224FF072F6C'
$url64             = 'https://packages.vmware.com/tools/releases/11.0.0/windows/x64/VMware-tools-11.0.0-14549434-x86_64.exe'
$checksum64        = '669946B5F1F01CF55A866BF42431F46374C4CFF274885A84ECABC51DC7EBB584'

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
