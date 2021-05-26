$ErrorActionPreference = 'Stop'
$packageName    = 'intel-proset-drivers' 
$toolsDir       = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
$unzipLocation  = "$toolsDir\unzipped"
$bits           = Get-ProcessorBits
#$url            = "https://downloadmirror.intel.com/30280/a08/WiFi_"+$ENV:ChocolateyPackageVersion+"_Driver32_Win10.zip"
$url            = "https://downloadmirror.intel.com/30280/a08/WiFi_22.40.0_Driver32_Win10.zip"
$checksum       = '5860F9D15D7D6648047834039A7E3086EE123650C437485D9EB11ED3433D5723'
#$url64          = "https://downloadmirror.intel.com/30280/eng/WiFi_"+$ENV:ChocolateyPackageVersion+"_Driver64_Win10.zip"
$url64          = "https://downloadmirror.intel.com/30280/a08/WiFi_22.40.0_Driver64_Win10.zip"
$checksum64     = '6741C919997CC335AE8437E5A48B748728EA8289698D227B3044E5791B8B1ED9'

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
