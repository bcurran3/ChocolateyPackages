$toolsDir       = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
$packageName    = 'hp-universal-print-driver-pcl' 
$url            = 'http://ftp.hp.com/pub/softlib/software13/COL40842/ds-99353-14/upd-pcl6-x32-6.4.1.22169.exe'
$checksum       = '126D541656C94DA2B3CD3FD9EF0BEB91C876393FC16308CA4D98202A5F1D4A9A'
$url64          = 'http://ftp.hp.com/pub/softlib/software13/COL39348/lj-95981-14/upd-pcl6-x64-6.4.1.22169.exe'
$checksum64     = '9C82B48D511E8F05144387662E6B8EC8EC834B20314B6C00B173B37C9A7512E0'
$installerType  = 'ZIP'
$silentArgs     = '/dm /nd /npf /q /h'
$validExitCodes = @(0, 3010, 1641)
$softwareName   = ''
$fileLocation   = "$toolsDir\unzippedfiles\install.exe"

New-Item $fileLocation -type directory | out-null

$packageArgs = @{
  packageName    = $packageName
  unzipLocation  = "$toolsDir\unzippedfiles"
  fileType       = 'ZIP' 
  url            = $url
  checksum       = $checksum
  checksumType   = 'sha256'
  url64          = $url64
  checksum64     = $checksum64
  checksumType64 = 'sha256'  
}

Install-ChocolateyZipPackage @packageArgs 

$packageArgs = @{
  packageName   = $packageName
  fileType      = 'EXE'
  file          = $fileLocation
  silentArgs    = $silentArgs
  validExitCodes= $validExitCodes
  softwareName  = $softwareName
}
 
Install-ChocolateyInstallPackage @packageArgs

Remove-Item "$toolsDir\unzippedfiles" -recurse | out-null

