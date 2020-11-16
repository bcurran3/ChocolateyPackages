$ErrorActionPreference = 'Stop'
# https://www.hexamail.com/download.html?page=response&did=NzgwMTc7NjA3NzA7MTU7MTI
$packageName = 'hexamail-pop3-downloader'
$toolsDir    = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
$url64       = 'https://www.hexamail.com/download/hexamailpop3downloadersetup5.9.38.003_64.exe'
$checksum64  = 'E832740797408207C5146D32C7FDABE9ED33F170EF0D0578BF4D311E9E70505F'

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
