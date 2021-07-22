$ErrorActionPreference = 'Stop'
$packageName    = 'getdataback-simple'
$toolsDir       = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
$url            = 'https://www.runtime.org/gdbprosetup.exe'
$checksum       = '4466B1113EF97C47DA4BE44E064D3085DF09522CCE30036DE14833DCAFFD4757'

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
