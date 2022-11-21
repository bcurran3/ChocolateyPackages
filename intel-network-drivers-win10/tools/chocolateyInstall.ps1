$ErrorActionPreference = 'Stop'
$packageName    = 'intel-network-drivers-win10' 
$toolsDir       = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
$unzipLocation  = "$toolsDir\unzipped"
$bits           = Get-ProcessorBits

Confirm-Win10

# Wired Drivers
$url            = "https://downloadmirror.intel.com/739880/Wired_driver_"+$ENV:ChocolateyPackageVersion+"_32.zip"
$checksum       = '556198EA2C61D192799D6FED1001FF76B3A8B8CE72ECB97DE7CF32AD429C1492'
$url64          = "https://downloadmirror.intel.com/739880/Wired_driver_"+$ENV:ChocolateyPackageVersion+"_x64.zip"
$checksum64     = '7229D7B96675F177F7442D62A0C3C5D079639A38FBC84FA1DDD6EF60220E29C2'

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
$url            = "https://downloadmirror.intel.com/739880/Wired_PROSet_"+$ENV:ChocolateyPackageVersion+"_32.zip"
$checksum       = '89285694ACE5804ABC3CDC17C01195DE286E886D8B787DA21924F925DDF4DD8B'
$url64          = "https://downloadmirror.intel.com/739880/Wired_PROSet_"+$ENV:ChocolateyPackageVersion+"_x64.zip"
$checksum64     = '870769D66A6BC64AC46033B6BC22DD2033B2FD00F30D136C506AE54CF06822E2'

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

