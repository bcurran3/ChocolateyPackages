# https://packages.vmware.com/tools/releases

$ErrorActionPreference = 'Stop'
$packageName       = 'vmware-tools'
$toolsDir          = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
$url               = 'https://packages.vmware.com/tools/releases/11.1.5/windows/x86/VMware-tools-11.1.5-16724464-i386.exe'
$checksum          = '53443098A1927A3227AD1E1B59935732426CBF2E7E84D3C3FDD502AB3454ABBD'
$url64             = 'https://packages.vmware.com/tools/releases/11.1.5/windows/x64/VMware-tools-11.1.5-16724464-x86_64.exe'
$checksum64        = '7919592ED91712205969848F0B9D8C278ABAF3DF6F31CEA16731F17FCD7F12EA'

$packageArgs = @{
  packageName    = $packageName
  fileType       = 'EXE'
  url            = $url
  url64bit       = $url64
  validExitCodes = @(0)
  silentArgs     = '/S /v /qn REBOOT=R ADDLOCAL=ALL'
  softwareName   = 'VMware Tools'
  checksum       = $checksum 
  checksumType   = 'sha256' 
  checksum64     = $checksum64
  checksumType64 = 'sha256'
}

Install-ChocolateyPackage @packageArgs  
