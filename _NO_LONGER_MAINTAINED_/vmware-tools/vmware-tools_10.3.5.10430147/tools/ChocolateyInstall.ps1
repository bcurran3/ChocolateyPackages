$ErrorActionPreference = 'Stop'
$packageName       = 'vmware-tools'
$toolsDir          = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
$url               = 'https://packages.vmware.com/tools/releases/10.3.5/windows/x86/VMware-tools-10.3.5-10430147-i386.exe'
$checksum          = '44172FD210DD305160BA9CA81CE8502418B07F2D1BC99F50006CF6BFF1A26868'
$url64             = 'https://packages.vmware.com/tools/releases/10.3.5/windows/x64/VMware-tools-10.3.5-10430147-x86_64.exe'
$checksum64        = '32631168F24A547836D9DAA9D19B1BB572C659436972B4D1A3B48A041F4BA8A4'

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
