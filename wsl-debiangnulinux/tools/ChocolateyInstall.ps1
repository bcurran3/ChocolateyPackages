$ErrorActionPreference = 'Stop'
$packageName    = 'wsl-debiangnulinux'
$toolsDir       = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
$url            = 'https://aka.ms/wsl-debian-gnulinux'
$checksum       = ''
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
Install-BinFile -Name SLES-12 -Path "$unzipLocation\SLES-12.exe"

Set-Location -Path $unzipLocation
.\SLES-12.exe
wslconfig /list