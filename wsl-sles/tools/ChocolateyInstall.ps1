$ErrorActionPreference = 'Stop'
$packageName    = 'wsl-sles'
$toolsDir       = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
$url            = 'https://aka.ms/wsl-sles-12'
$checksum       = 'FEE6FCC02EE8001173B019F8DF5AEB4F07D6892FB89FE3EB6E4A2C0166EF6D67'
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
Install-BinFile -Name SLES -Path "$unzipLocation\SLES-12.exe"

Set-Location -Path $unzipLocation
.\SLES-12.exe
wslconfig /list