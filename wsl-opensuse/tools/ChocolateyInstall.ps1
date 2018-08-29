$ErrorActionPreference = 'Stop'
$packageName    = 'wsl-opensuse'
$toolsDir       = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
$url            = 'https://aka.ms/wsl-opensuse-42'
$checksum       = '7E8D474A53631C4843C7F209E3530B777A40F6DA12B9C91AEA418071D76DCA02'
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
.\openSUSE-42.exe run exit
wslconfig /list