$ErrorActionPreference = 'Stop'
$packageName    = 'intel-proset-drivers' 
$toolsDir       = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
$unzipLocation  = "$toolsDir\unzipped"
$url            = "https://downloadmirror.intel.com/30567/a08/WiFi_"+$ENV:ChocolateyPackageVersion+"_Driver32_Win10.zip"
$checksum       = '63A0C3E7BEB6150EB41CC3FA2BEEC6453D83DB26526ADE255CB5EB21C7A5AEB7'
$url64          = "https://downloadmirror.intel.com/30567/a08/WiFi_"+$ENV:ChocolateyPackageVersion+"_Driver64_Win10.zip"
$checksum64     = 'EF938F6356582380877A15BC41859BDDC2F5A78B845CB3FDF91B2814D39CA6D5'

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

Remove-Item $unzipLocation -Recurse -Force | Out-Null
