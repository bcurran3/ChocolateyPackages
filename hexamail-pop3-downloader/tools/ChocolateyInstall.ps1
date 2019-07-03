$ErrorActionPreference = 'Stop'
# https://www.hexamail.com/download.html?page=response&did=NzgwMTc7NjA3NzA7MTU7MTI
$packageName = 'hexamail-pop3-downloader'
$toolsDir    = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
$url64       = 'https://www.hexamail.com/download/hexamailpop3downloadersetup5.9.22.002_64.exe'
$checksum64  = '73FB2CA4A8A40C52F557360CCC12B1450EF8768D2AC199FD5261794BDAC7274C'

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
