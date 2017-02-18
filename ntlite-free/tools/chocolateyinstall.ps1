$ErrorActionPreference = 'Stop'
$packageName   = 'ntlite-free'
$installerType = 'exe'
$toolsDir      = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
$url           = 'http://downloads.ntlite.com/files/NTLite_setup_x86.exe' 
$checksum      = '0db1b1961c351e05d10366852391a2b011b57816'
$url64         = 'http://downloads.ntlite.com/files/NTLite_setup_x64.exe' 
$checksum64    = '3e5e64a4349deb059b22248fbc796a9561088470'
$silentArgs    = '/VERYSILENT /SUPPRESSMSGBOXES /NORESTART /SP-'
$validExitCodes= @(0)

$packageArgs = @{
  packageName   = $packageName
  fileType      = $installerType
  url           = $url
  url64bit      = $url64
  validExitCodes= $validExitCodes
  silentArgs    = $silentArgs
  softwareName  = 'VMware Tools'
  checksum      = $checksum 
  checksumType  = 'sha256' 
  checksum64    = $checksum64
  checksumType64= 'sha256'
}

Install-ChocolateyPackage @packageArgs  
  
