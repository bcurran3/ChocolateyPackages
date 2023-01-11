$ErrorActionPreference = 'Stop'
$packageName    = 'intel-network-drivers-win10' 
$toolsDir       = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
$unzipLocation  = "$toolsDir\unzipped"
$bits           = Get-ProcessorBits

Confirm-Win10

# Wired Drivers
$url            = "https://downloadmirror.intel.com/764809/Wired_driver_"+$ENV:ChocolateyPackageVersion+"_32.zip"
#                                                   ^^^^^^ changes
$checksum       = 'F04B6789CE569B86597DB8F2EC8505252A096E51D599324D86C0549FB5DD6EE1'
$url64          = "https://downloadmirror.intel.com/764809/Wired_driver_"+$ENV:ChocolateyPackageVersion+"_x64.zip"
#                                                   ^^^^^^ changes
$checksum64     = 'A0F75BCCDC84DE454C515D9B8FA1DD84E49CE3273F9EB5E7201B1AD6F7AD139F'

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
$url            = "https://downloadmirror.intel.com/764809/Wired_PROSet_"+$ENV:ChocolateyPackageVersion+"_32.zip"
#                                                   ^^^^^^ changes
$checksum       = 'C2DBA17F635B2D09CA297A06AAE0399BDBDE877B78DEA01E630351629609DA1C'
$url64          = "https://downloadmirror.intel.com/764809/Wired_PROSet_"+$ENV:ChocolateyPackageVersion+"_x64.zip"
#                                                   ^^^^^^ changes
$checksum64     = '3E27D2E61B73C0DD9C6D1363134BE63CC61C44FF8CAD8C8DDC4F78CCE5104E4A'

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

