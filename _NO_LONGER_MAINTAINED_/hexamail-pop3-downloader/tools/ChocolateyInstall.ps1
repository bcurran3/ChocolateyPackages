$ErrorActionPreference = 'Stop'
# https://www.hexamail.com/download.html?page=response&did=NzgwMTc7NjA3NzA7MTU7MTI <- requires auth now
$packageName = 'hexamail-pop3-downloader'
$toolsDir    = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
$url64       = 'https://www.hexamail.com/download/hexamailpop3downloadersetup5.9.84.001_64.exe'
$checksum64  = 'EBD8714E72190AC1E37147235F4C25BF2CA7A02C1A4D89E4873A80D78E44FCCD'

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
