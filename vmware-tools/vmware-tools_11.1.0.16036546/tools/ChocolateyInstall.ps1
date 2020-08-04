$ErrorActionPreference = 'Stop'
$packageName       = 'vmware-tools'
$toolsDir          = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
$url               = 'https://packages.vmware.com/tools/releases/11.1.0/windows/x86/VMware-tools-11.1.0-16036546-i386.exe'
$checksum          = 'AD422FC4F067650DBA9F8ED7F15A48127B94AD25213C1E60B23B76C7BCA2AD29'
$url64             = 'https://packages.vmware.com/tools/releases/11.1.0/windows/x64/VMware-tools-11.1.0-16036546-x86_64.exe'
$checksum64        = 'A79872EBFAE22C8D681E350FFF90C0880CF3A80FA26194EF566E24B011FB439D'

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
