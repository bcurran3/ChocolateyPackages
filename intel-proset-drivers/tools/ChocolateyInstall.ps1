$ErrorActionPreference = 'Stop'
$packageName    = 'intel-proset-drivers' 
$toolsDir       = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
$unzipLocation  = "$toolsDir\unzipped"
$bits           = Get-ProcessorBits
$url            = "https://downloadmirror.intel.com/29536/a08/WiFi_"+$ENV:ChocolateyPackageVersion+"_Driver32_Win10.zip"
$checksum       = '9F156E64EC83A2F07B38AB672CB3EA6695BC9AA265D900914E89E39B7F8B25EA'
$url64          = "https://downloadmirror.intel.com/29536/a08/WiFi_"+$ENV:ChocolateyPackageVersion+"_Driver64_Win10.zip"
$checksum64     = 'DFCE02C068003F38C549CB586C1848F47323F001C3B32CFD624DB10610002500'

# Last Windows 7+8 version was 21.40.5
# No need to check for hardware, drivers install even if an Intel PROSet/Wireless card is not found

if (!(Test-Dependency "dependency-windows10")) {throw}

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

pnputil /add-driver $unzipLocation\*.inf /install

Remove-Item $unzipLocation -Recurse | Out-Null
