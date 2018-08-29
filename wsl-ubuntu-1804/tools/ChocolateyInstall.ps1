$ErrorActionPreference = 'Stop'
$packageName    = 'wsl-ubuntu-1804'
$toolsDir       = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
$url            = 'https://aka.ms/wsl-ubuntu-1804'
$checksum       = '96E4E3E336F08DDE1DF81FA9C266C5C7750BA92729857E92BDE36BF84A1DB002'
$unzipLocation  = "$toolsDir\unzipped"

New-Item $unzipLocation -type directory | out-null

$packageArgs = @{
  packageName    = $packageName
  unzipLocation  = $unzipLocation
  fileType       = 'ZIP' 
  url            = $url
  checksum       = $checksum
  checksumType   = 'sha256'
}

Install-ChocolateyZipPackage @packageArgs 

Set-Location -Path $unzipLocation
ubuntu1804.exe install
wslconfig /list