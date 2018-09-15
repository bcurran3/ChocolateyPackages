$ErrorActionPreference = 'Stop'
$packageName       = 'vmware-tools'
$toolsDir          = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
$url               = 'https://packages.vmware.com/tools/releases/10.3.2/windows/x86/VMware-tools-10.3.2-9925305-i386.exe'
$checksum          = '145FF4316DE2FD5E438005859D49532D3FE1CA865077E452BAD1E7CE75869B86'
$url64             = 'https://packages.vmware.com/tools/releases/10.3.2/windows/x64/VMware-tools-10.3.2-9925305-x86_64.exe'
$checksum64        = 'D46545095539CA67058954C908E51F1B823CDD89F480D30C4DADE3A5F28F16E7'

$packageArgs = @{
  packageName   = $packageName
  fileType      = 'EXE'
  url           = $url
  url64bit      = $url64
  validExitCodes= @(0)
  silentArgs    = '/S /v /qn REBOOT=R'
  softwareName  = 'VMware Tools'
  checksum      = $checksum 
  checksumType  = 'sha256' 
  checksum64    = $checksum64
  checksumType64= 'sha256'
}

Install-ChocolateyPackage @packageArgs  
