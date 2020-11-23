$ErrorActionPreference = 'Stop'
$packageName    = 'intel-proset-drivers' 
$toolsDir       = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
$unzipLocation  = "$toolsDir\unzipped"
$bits           = Get-ProcessorBits
$url            = "https://downloadmirror.intel.com/29903/a08/WiFi_"+$ENV:ChocolateyPackageVersion+"_Driver32_Win10.zip"
$checksum       = '8F91BF68416684B02809EFB4F59286881CD1CC825A869C967AB40D651210D884'
$url64          = "https://downloadmirror.intel.com/29903/eng/WiFi_"+$ENV:ChocolateyPackageVersion+"_Driver64_Win10.zip"
$checksum64     = '035457D4CCB3F965DB6DF086573F5B26209736119D6A97CEA7857BA0B1FA6BA8'

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
