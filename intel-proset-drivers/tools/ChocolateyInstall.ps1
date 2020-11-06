$ErrorActionPreference = 'Stop'
$packageName    = 'intel-proset-drivers' 
$toolsDir       = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
$unzipLocation  = "$toolsDir\unzipped"
$bits           = Get-ProcessorBits
$url            = "https://downloadmirror.intel.com/29850/a08/WiFi_"+$ENV:ChocolateyPackageVersion+"_Driver32_Win10.zip"
$checksum       = 'E091AE8A715117D6CB210D09FD8038FE844AA95391702EDCEE0B0A7D69545876'
$url64          = "https://downloadmirror.intel.com/29850/a08/WiFi_"+$ENV:ChocolateyPackageVersion+"_Driver64_Win10.zip"
$checksum64     = '790D0D379CE2CAE8307E2760A95640639C529B5FE680A543E408442135C15A22'

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
