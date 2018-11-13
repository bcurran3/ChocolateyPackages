$packageName    = 'dokany'
$toolsDir       = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
$url            = 'https://github.com/dokan-dev/dokany/releases/download/v1.2.0.1000/Dokan_x86.msi' 
$checksum       = 'F3086854373C68214CAEBF3EF8E2688A530EBC0C52179A80E42A866B6D993A0B'
$url64          = 'https://github.com/dokan-dev/dokany/releases/download/v1.2.0.1000/Dokan_x64.msi' 
$checksum64     = 'DF82917530BC023BEBE352679B82EA76F99337D7E45E91EAC089FA416015D3A6'

$packageArgs = @{
  packageName   = $packageName
  fileType      = 'MSI'
  url           = $url
  url64bit      = $url64
  validExitCodes= @(0, 3010, 1641)
  silentArgs    = '/passive /norestart'
  softwareName  = 'Dokan Library*'
  checksum      = $checksum
  checksumType  = 'sha256' 
  checksum64    = $checksum64
  checksumType64= 'sha256'
}

Install-ChocolateyPackage @packageArgs  
