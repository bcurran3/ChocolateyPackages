$ErrorActionPreference = 'Stop'
# https://www.hexamail.com/download.html?page=response&did=NzgwMTc7NjA3NzA7MTU7MTI
$packageName = 'hexamail-pop3-downloader'
$toolsDir    = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
$url64       = 'https://www.hexamail.com/download/hexamailpop3downloadersetup5.9.34.001_64.exe'
$checksum64  = '823C7B68C91B3AC458F5E732F4DC097FE142C2DBD032FE501A41B28868DFEFC6'

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
