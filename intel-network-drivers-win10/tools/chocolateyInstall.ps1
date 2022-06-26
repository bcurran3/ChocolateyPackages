$ErrorActionPreference = 'Stop'
$packageName    = 'intel-network-drivers-win10' 
$toolsDir       = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
$unzipLocation  = "$toolsDir\unzipped"
$bits           = Get-ProcessorBits

Confirm-Win10

# Wired Drivers
$url            = "https://downloadmirror.intel.com/735339/Wired_driver_"+$ENV:ChocolateyPackageVersion+"_32.zip"
$checksum       = '0073F808DB8D47D937EF9265CDFD6F40151F24295D1C8E0B90C4A5FA3903444E'
$url64          = "https://downloadmirror.intel.com/735339/Wired_driver_"+$ENV:ChocolateyPackageVersion+"_x64.zip"
$checksum64     = 'B1D945C00FCB851B52B6DEE3A188B8F914212A3F9B0D070050A9D348CDA990CA'

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
$url            = "https://downloadmirror.intel.com/735339/Wired_PROSet_"+$ENV:ChocolateyPackageVersion+"_32.zip"
$checksum       = '8E676AFCFD8509AEC0EADD183078EB9CCADA6AE550BCC0A493957E731DF96445'
$url64          = "https://downloadmirror.intel.com/735339/Wired_PROSet_"+$ENV:ChocolateyPackageVersion+"_x64.zip"
$checksum64     = 'EBEF61433978AC18646267CACF1B419B15FA97D301BB237ED70845B3BBAD35D5'

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

# replace this with Get-IsWin10 from chocolatey-fastanswers.extension.0.0.3
$OSBuild=[Environment]::OSVersion.Version.Build
if ($OSBuild -lt 22000)
{
# Win10 only
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

