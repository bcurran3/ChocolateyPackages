$ErrorActionPreference = 'Stop'
$packageName    = 'wsl-kalilinux'
$toolsDir       = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
$unzipLocation  = "$toolsDir\unzipped"
$unzipLocation2 = "$toolsDir\unzipped2"
$url            = 'https://aka.ms/wsl-kali-linux'
$checksum       = 'E559A7771BEA595E7468A10DA62DF4DA551A11320487F5DDFCDD5A8284BDAE01'
$url2           = "$unzipLocation\DistroLauncher-Appx_1.1.4.0_x64.appx"
$checksum2      = '61FEB10BE30EB17FB2F1E263E2E61BAA35EBBC7E8AA47D524DC0801325D2C444'

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
  unzipLocation  = $unzipLocation2
  fileType       = 'ZIP' 
  url            = $url2
  checksum       = $checksum2
  checksumType   = 'sha256'
}

Install-ChocolateyZipPackage @packageArgs

Set-Location -Path $unzipLocation2
./kali.exe install --root
wslconfig /list

# There might be more that could be done here.
# https://www.kali.org/tutorials/kali-on-the-windows-subsystem-for-linux/