$ErrorActionPreference = 'Stop'
$packageName    = 'getdataback-simple'
$toolsDir       = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
$url            = 'https://www.runtime.org/gdbprosetup.exe'
$checksum       = 'B6C6E382210D3485015ED05C5534F7C094DBBBA535566CA1C497106B37B869BE'

$packageArgs = @{
  packageName    = $packageName
  unzipLocation  = $toolsDir  
  fileType       = 'EXE'
  url            = $url
  validExitCodes = @(0)
  silentArgs     = '/VERYSILENT /SUPPRESSMSGBOXES /NORESTART /SP-'
  softwareName   = 'GetDataBack*'
  checksum       = $checksum
  checksumType   = 'sha256' 
}

Install-ChocolateyPackage @packageArgs
