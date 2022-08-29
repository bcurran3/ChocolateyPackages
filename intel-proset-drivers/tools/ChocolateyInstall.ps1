$ErrorActionPreference = 'Stop'
$packageName    = 'intel-proset-drivers' 
$toolsDir       = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
$unzipLocation  = "$toolsDir\unzipped"
$url            = "https://downloadmirror.intel.com/736240/WiFi-"+$ENV:ChocolateyPackageVersion+"-Driver32_Win10.zip"
#                                                   ^^^^^^ changes
$checksum       = 'EC9C10FBB0C9978AFC4210BCE4A87F71E5645DD1F6822EA41FABBA5CB0A9D74F'
$url64          = "https://downloadmirror.intel.com/736240/WiFi-"+$ENV:ChocolateyPackageVersion+"-Driver64-Win10-Win11.zip"
#                                                   ^^^^^^ changes
$checksum64     = '3E8B762BD324355906EA8D9841789DBFFEE6491DEB1FF1591E565EE56CA51C56'

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
