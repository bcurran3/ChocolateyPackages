$ErrorActionPreference = 'Stop'
$packageName = 'take-command'
$toolsDir    = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
$url         = 'https://jpsoft.com/downloads/v24/tcmd.exe'
$checksum    = 'D3355417CA334FAB73B2D9DEFA5E453F7317F9D480FCEC5EADB37DC1B7F77B00'


$packageArgs = @{
  packageName    = $packageName
  unzipLocation  = $toolsDir
  fileType       = 'EXE'
  url            = $url
  checksum       = $checksum 
  checksumType   = 'sha256'
  softwareName   = 'Take Command*'
  silentArgs     = '/Q'
  validExitCodes = @(0) 
}

Install-ChocolateyPackage @packageArgs 
