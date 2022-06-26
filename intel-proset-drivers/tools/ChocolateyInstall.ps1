$ErrorActionPreference = 'Stop'
$packageName    = 'intel-proset-drivers' 
$toolsDir       = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
$unzipLocation  = "$toolsDir\unzipped"
$url            = "https://downloadmirror.intel.com/732829/WiFi-"+$ENV:ChocolateyPackageVersion+"-Driver32_Win10.zip"
#                                                   ^^^^^^ changes
$checksum       = 'D1B5FEDD0D43B394F01F934717524003548BD7E958E255AC08852A8808A9F57C'
$url64          = "https://downloadmirror.intel.com/732829/WiFi-"+$ENV:ChocolateyPackageVersion+"-Driver64-Win10-Win11.zip"
#                                                   ^^^^^^ changes
$checksum64     = 'AEDE34D8E047D92059FEA4F405ECB26F45FBDC50608BC1C0410402970C52E7AC'

# Last Windows 7+8 version was 21.40.5
# No need to check for hardware, drivers install even if an Intel PROSet/Wireless card is not found

Confirm-Win10

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
