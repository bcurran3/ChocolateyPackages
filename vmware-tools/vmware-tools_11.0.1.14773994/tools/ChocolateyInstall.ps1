$ErrorActionPreference = 'Stop'
$packageName       = 'vmware-tools'
$toolsDir          = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
$url               = 'https://packages.vmware.com/tools/releases/11.0.1/windows/x86/VMware-tools-11.0.1-14773994-i386.exe'
$checksum          = 'A1FEDDDE8DC57B8BBE072E8D67CD821DA7C2528CB0E3A80FDBBCB0EA75F6D3F2'
$url64             = 'https://packages.vmware.com/tools/releases/11.0.1/windows/x64/VMware-tools-11.0.1-14773994-x86_64.exe'
$checksum64        = 'D9BE414DD2A964E85F68069F91B0C7D3BF245BBD3091025AFFA448B91CF160DB'

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
