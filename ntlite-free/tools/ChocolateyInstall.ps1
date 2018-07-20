$ErrorActionPreference = 'Stop'
$global:packageMaintainer = 'BCURRAN3'
$packageName    = 'ntlite-free'
$installerType  = 'exe'
$toolsDir       = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
$url            = 'http://downloads.ntlite.com/files/NTLite_setup_x86.exe' 
$checksum       = '6F9CEE325E19D117791B5F4C9633E14D9D6FAC49EBF52ED1B6A3C1881C0E6586'
$url64          = 'http://downloads.ntlite.com/files/NTLite_setup_x64.exe' 
$checksum64     = '94C520B62A554B47CB645153451C4BCE311806F32F182B6CE83FA3E793EA14D2'
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

Show-Patreon "https://www.patreon.com/bcurran3"
Install-ChocolateyPackage @packageArgs
Show-ToastMessage "$packageName installed." "Version $env:packageVersion."
  
