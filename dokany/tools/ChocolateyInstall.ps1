$packageName    = 'dokany'
$global:packageMaintainer = 'BCURRAN3'
$installerType  = 'msi'
$toolsDir       = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
$url            = 'https://github.com/dokan-dev/dokany/releases/download/v1.1.0.2000/Dokan_x86.msi' 
$checksum       = 'FC078E844EA492D7A11701BBA593E1ED7736E4AB9E112B9CD79217C529E35002'
$url64          = 'https://github.com/dokan-dev/dokany/releases/download/v1.1.0.2000/Dokan_x64.msi' 
$checksum64     = 'F48B8663BB699A21BF338B1A1171DE45F8B516CEB23C15F4AA426F0914A406CC'
$silentArgs     = '/passive /norestart'
$validExitCodes = @(0, 3010, 1641)

$packageArgs = @{
  packageName   = $packageName
  fileType      = $installerType
  url           = $url
  url64bit      = $url64
  validExitCodes= $validExitCodes
  silentArgs    = $silentArgs
  softwareName  = 'Dokan Library*'
  checksum      = $checksum
  checksumType  = 'sha256' 
  checksum64    = $checksum64
  checksumType64= 'sha256'
}

Show-Patreon "https://www.patreon.com/bcurran3"
Install-ChocolateyPackage @packageArgs  
Show-ToastMessage "$packageName installed." "Version $env:packageVersion."
  
