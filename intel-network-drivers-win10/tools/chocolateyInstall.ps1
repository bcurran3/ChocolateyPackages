$ErrorActionPreference = 'Stop'
$packageName    = 'intel-network-drivers-win10' 
$toolsDir       = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
$unzipLocation  = "$toolsDir\unzipped"
$bits           = Get-ProcessorBits
$IntelPackageNumber = "785800"

Confirm-Win10

# Drivers
$url            = "https://downloadmirror.intel.com/$IntelPackageNumber/Wired_driver_"+$ENV:ChocolateyPackageVersion+"_32.zip"
$checksum       = 'C9E02CDC17E9739B3AF0458CD16535E64A15C218FCD459835D2425B3D2449CB8'
$url64          = "https://downloadmirror.intel.com/$IntelPackageNumber/Wired_driver_"+$ENV:ChocolateyPackageVersion+"_x64.zip"
$checksum64     = '0D10E40853836E94F3CDFFD566CAF324259F776258A7E9757D159BE62C706BAD'

$packageArgs = @{
  packageName    = $packageName
  unzipLocation  = $unzipLocation
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
  packageName    = $packageName
  Destination    = $unzipLocation
  FileFullPath   = "$unzipLocation\Wired_driver_"+$ENV:ChocolateyPackageVersion+"_32.exe"
  FileFullPath64 = "$unzipLocation\Wired_driver_"+$ENV:ChocolateyPackageVersion+"_x64.exe"
}

Get-ChocolateyUnzip @packageArgs


pnputil /add-driver $unzipLocation\*.inf /install /subdirs

# PROSet software
$url            = "https://downloadmirror.intel.com/$IntelPackageNumber/Wired_PROSet_"+$ENV:ChocolateyPackageVersion+"_32.zip"
$checksum       = '00300C2934305A6438A985131346899FE264E74E338E6E1996E9F230D3E4E57D'
$url64          = "https://downloadmirror.intel.com/$IntelPackageNumber/Wired_PROSet_"+$ENV:ChocolateyPackageVersion+"_x64.zip"
$checksum64     = 'F7DB9FC5A499BBFFEEA85C4B5C2876DEC8AAD84A439F0EC9AAE16B5130CF8194'

$packageArgs = @{
  packageName    = $packageName
  unzipLocation  = $unzipLocation
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
  packageName    = $packageName
  Destination    = $unzipLocation
  FileFullPath   = "$unzipLocation\Wired_PROSet_"+$ENV:ChocolateyPackageVersion+"_32.exe"
  FileFullPath64 = "$unzipLocation\Wired_PROSet_"+$ENV:ChocolateyPackageVersion+"_x64.exe"
}

Get-ChocolateyUnzip @packageArgs

$OSBuild=[Environment]::OSVersion.Version.Build
if ($OSBuild -lt 22000)
{
# Win10 only - no Win11 support
$packageArgs = @{
  packageName    = $packageName
  fileType       = 'EXE'
  file           = "$unzipLocation\APPS\PROSETDX\Win32\DxSetup.exe"
  file64         = "$unzipLocation\APPS\PROSETDX\Winx64\DxSetup.exe"
  silentArgs     = '/quiet /qn /norestart'
  validExitCodes = @(0,1150)
  softwareName   = 'Intel(R) Network Connections*'
}
 
Install-ChocolateyInstallPackage @packageArgs
}

Start-CheckandStop msiexec
Remove-Item $unzipLocation -Recurse -EA SilentlyContinue | Out-Null

# UPDATE INSTRUCTIONS:
# Update IntelPackageNumber and checksums
