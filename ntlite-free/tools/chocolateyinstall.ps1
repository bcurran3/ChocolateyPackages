$ErrorActionPreference = 'Stop'
$packageName    = 'ntlite-free'
$installerType  = 'exe'
$toolsDir       = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
$url            = 'http://downloads.ntlite.com/files/NTLite_setup_x86.exe' 
$checksum       = 'D13E040440ED2048B9AFB1E1EA377AD8F0D6F403916653948D04BA9AF29809B7'
$url64          = 'http://downloads.ntlite.com/files/NTLite_setup_x64.exe' 
$checksum64     = 'BE9CF9718195A0ACAD77A772E92C837964F295AC27F11A1831A75A630F4CD64B'
$silentArgs     = '/VERYSILENT /SUPPRESSMSGBOXES /NORESTART /SP-'
$validExitCodes = @(0)

$packageArgs = @{
  packageName   = $packageName
  fileType      = $installerType
  url           = $url
  url64bit      = $url64
  validExitCodes= $validExitCodes
  silentArgs    = $silentArgs
  softwareName  = 'NTLite*'
  checksum      = $checksum 
  checksumType  = 'sha256' 
  checksum64    = $checksum64
  checksumType64= 'sha256'
}

Install-ChocolateyPackage @packageArgs  
  
