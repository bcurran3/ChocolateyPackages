$ErrorActionPreference = 'Stop'
$packageName       = 'vmware-tools'
$toolsDir          = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
$url               = 'https://packages.vmware.com/tools/releases/11.0.5/windows/x86/VMware-tools-11.0.5-15389592-i386.exe'
$checksum          = '96275DA2BD98EC567BEA632277A084BDDD3BAC64E3EFD1E87BC713794D2443FE'
$url64             = 'https://packages.vmware.com/tools/releases/11.0.5/windows/x64/VMware-tools-11.0.5-15389592-x86_64.exe'
$checksum64        = '7D93AE3CFAEF4BA8C30E4210A83EDBA1DAA135525FF2CB35651C029BE54AC638'

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
