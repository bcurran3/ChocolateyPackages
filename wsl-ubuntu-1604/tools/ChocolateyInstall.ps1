$ErrorActionPreference = 'Stop'
$packageName    = 'wsl-ubuntu-1604'
$toolsDir       = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
$url            = 'https://aka.ms/wsl-ubuntu-1604'
$checksum       = '24F2926D359B6ABAE595CDA7300AEDC567C294777D4BFC8AACC0E6598DB9680A'
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
Install-BinFile -Name Ubuntu1604 -Path "$unzipLocation\Ubuntu.exe"

Set-Location -Path $unzipLocation
ubuntu.exe install
wslconfig /list