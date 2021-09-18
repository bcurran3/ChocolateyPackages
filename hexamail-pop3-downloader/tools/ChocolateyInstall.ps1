$ErrorActionPreference = 'Stop'
# https://www.hexamail.com/download.html?page=response&did=NzgwMTc7NjA3NzA7MTU7MTI
$packageName = 'hexamail-pop3-downloader'
$toolsDir    = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
$url64       = 'https://www.hexamail.com/download/hexamailpop3downloadersetup5.9.38.003_64.exe'
$checksum64  = 'FBDD05E8F5755B814986754B6DE62BECDCAE0F8BC1AEEF69A44B5AE5A3188F26'

$packageArgs = @{
  packageName    = $packageName
  unzipLocation  = $toolsDir  
  fileType       = 'EXE'
  url64          = $url64
  validExitCodes = @(0,1)
  silentArgs     = '/Q'
  softwareName   = 'Hexamail POP3 Downloader*'
  checksum64     = $checksum64
  checksumType64 = 'sha256' 
}

Install-ChocolateyPackage @packageArgs
