$ErrorActionPreference = 'Stop'
$packageName    = 'wsl-ubuntu-1804'
$toolsDir       = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
$url            = 'https://aka.ms/wsl-ubuntu-1804'
$checksum       = '0B1ABE8D5DC3FF416A06C9524E4F61A1FDF6CED583CB9B297EE72DF1732FF403'
$unzipLocation  = "$toolsDir\unzipped"
$exe            = "ubuntu1804.exe"

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

$packageArgs = @{
  packageName    = $packageName
  softwareName   = ''
  fileType       = 'EXE'
  silentArgs     = 'install --root'
  file           = "$unzipLocation\$exe"
  validExitCodes = @(0)
  }

Install-ChocolateyInstallPackage @packageArgs
wslconfig /list

# CONSIDER: change to Add-AppxPackage .\ubuntu-1804.appx ????? 
# https://apps.microsoft.com/store/detail/ubuntu-18045-lts/9PNKSF5ZN4SW