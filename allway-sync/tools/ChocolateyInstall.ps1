$ErrorActionPreference = 'Stop'
$packageName = 'allway-sync' 
$global:packageMaintainer = 'BCURRAN3'
$toolsDir    = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
$url         = 'https://allwaysync.com/content/download/allwaysync-18-4-8.exe'
$checksum    = '826B14B3B7DDB1BFC912BED046E78158D81E60F6C9BB8762EFCD12F165C74A58'
$url64       = 'https://allwaysync.com/content/download/allwaysync-x64-18-4-8.exe'
$checksum64  = '172B7C692B56FF3E978995971D5E86810A5EEB00FBD2C696F48A012B33FCDDA4'
$silentArgs  = '/VERYSILENT /SUPPRESSMSGBOXES /NORESTART /SP-' 

$packageArgs = @{
  packageName   = $packageName
  unzipLocation = $toolsDir
  fileType      = 'exe' 
  url           = $url
  checksum      = $checksum
  checksumType  = 'sha256'  
  url64bit      = $url64
  checksum64    = $checksum64
  checksumType64= 'sha256'
  silentArgs    = $silentArgs
  softwareName  = 'Allway Sync*' 
  }
  
Show-Patreon "https://www.patreon.com/bcurran3"  
Install-ChocolateyPackage @packageArgs
Show-ToastMessage "$packageName installed." "Version $env:packageVersion."
