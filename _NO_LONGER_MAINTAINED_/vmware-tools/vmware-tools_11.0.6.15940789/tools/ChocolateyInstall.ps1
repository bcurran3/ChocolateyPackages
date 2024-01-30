$ErrorActionPreference = 'Stop'
$packageName       = 'vmware-tools'
$toolsDir          = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
$url               = 'https://packages.vmware.com/tools/releases/11.0.6/windows/x86/VMware-tools-11.0.6-15940789-i386.exe'
$checksum          = 'AD3ADB80E7B3C0B70596AC50AD8EE9B3EFD5091B8424715DDE6AB3F18ECED579'
$url64             = 'https://packages.vmware.com/tools/releases/11.0.6/windows/x64/VMware-tools-11.0.6-15940789-x86_64.exe'
$checksum64        = 'F83A4AFD28A220289724CC78A67AB7F89DA13668C5DEBDE45DD6527BBECEB03C'

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
