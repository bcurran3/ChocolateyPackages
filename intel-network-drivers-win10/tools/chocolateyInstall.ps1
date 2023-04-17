$ErrorActionPreference = 'Stop'
$packageName    = 'intel-network-drivers-win10' 
$toolsDir       = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
$unzipLocation  = "$toolsDir\unzipped"
$bits           = Get-ProcessorBits
$IntelPackageNumber = "772070"

Confirm-Win10

# Wired Drivers
$url            = "https://downloadmirror.intel.com/$IntelPackageNumber/Wired_driver_"+$ENV:ChocolateyPackageVersion+"_32.zip"
$checksum       = '6D02C9E8425F6DDAD180B957E4F0986647128661F6F23AFA70B83DCD342239AF'
$url64          = "https://downloadmirror.intel.com/$IntelPackageNumber/Wired_driver_"+$ENV:ChocolateyPackageVersion+"_x64.zip"
$checksum64     = 'B99A6A996091C56A60902B5D777E850AC82931818BF7FFBACF2CAFD33EB067A5'

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

# Wired PROSet drivers
$url            = "https://downloadmirror.intel.com/$IntelPackageNumber/Wired_PROSet_"+$ENV:ChocolateyPackageVersion+"_32.zip"
$checksum       = '4C12489DB8769C71E25E8C29CC591D588DC40A95A7153CCE1B88E26E5477F110'
$url64          = "https://downloadmirror.intel.com/$IntelPackageNumber/Wired_PROSet_"+$ENV:ChocolateyPackageVersion+"_x64.zip"
$checksum64     = '7833CBE5825F4BA9021E95488416335302B5EE6D43C2318768CBAA971BFDEC4D'

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
