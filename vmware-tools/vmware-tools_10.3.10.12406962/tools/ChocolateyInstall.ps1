$ErrorActionPreference = 'Stop'
$packageName       = 'vmware-tools'
$toolsDir          = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
$url               = 'https://packages.vmware.com/tools/releases/10.3.10/windows/x86/VMware-tools-10.3.10-12406962-i386.exe'
$checksum          = '59A498CC1641A04C10D08709AC6DC6AA95CAFC7B56E6D613D3630E89083F0F4C'
$url64             = 'https://packages.vmware.com/tools/releases/10.3.10/windows/x64/VMware-tools-10.3.10-12406962-x86_64.exe'
$checksum64        = '65D5CC22D2FAE73F104E985BAA7885A1544ADCEB0774CC302522C03541E5DD82'

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
