﻿# https://www.hexamail.com/download.html?page=response&did=NzgwMTc7NjA3NzA7MTU7MTI
$packageName    = 'hexamail-pop3-downloader'
$toolsDir       = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
$bits           = Get-ProcessorBits
$url            = 'https://www.hexamail.com/download/hexamailpop3downloadersetup5.9.16.002_64.exe'
$checksum       = '9D6A8BAC6197FD2210E134AB2E5A8487333C1460D7C7EA040C435E9D2FD9C5AC'

$packageArgs = @{
  packageName    = $packageName
  unzipLocation  = $toolsDir  
  fileType       = 'EXE'
  url64bit       = $url
  validExitCodes = @(0,1)
  silentArgs     = '/Q'
  softwareName   = 'Hexamail POP3 Downloader*'
  checksum64     = $checksum
  checksumType64 = 'sha256' 
}

Install-ChocolateyPackage @packageArgs
