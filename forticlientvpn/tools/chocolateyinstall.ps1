$ErrorActionPreference = 'Stop'
$packageName   = 'forticlientvpn'
$toolsDir      = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
$url           = 'https://filestore.fortinet.com/forticlient/downloads/FortiClientVPNSetup_7.0.1.0083.zip'
checksum       = 'd0d31562aca5e3b652dfef86085d9c72ff6ed0f960f51e44a506fc4aef7f91b9'
$url64         = 'https://filestore.fortinet.com/forticlient/downloads/FortiClientVPNSetup_7.0.1.0083_x64.zip.zip'
$checksum64    = '1f218f32abd41c678cc7dbc50a4da70fbe7c7647518555268a2a55068fc56b96'
$fileLocation  = Join-Path $toolsDir 'FortiClientVPN.msi'

$packageArgs = @{
  packageName   = $packageName
  unzipLocation = $toolsDir
  fileType      = 'MSI'
  url           = $url
  url64         = $url64
  file          = $fileLocation
  silentArgs    = "/qn /norestart /l*v `"$($env:TEMP)\$($packageName).$($env:chocolateyPackageVersion).MsiInstall.log`""
  softwareName  = 'FortiClient VPN' 
  checksum      = $checksum
  checksum64    = $checksum64
  checksumType  = 'sha256'
  }

Install-ChocolateyZipPackage @packageArgs
Install-ChocolateyInstallPackage @packageArgs