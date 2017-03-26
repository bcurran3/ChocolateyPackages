$packageName    = 'dokany'
$installerType  = 'msi'
$toolsDir       = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
$url            = 'https://github.com/dokan-dev/dokany/releases/download/v1.0.3/Dokan_x86.msi' 
$checksum       = '1A8E3F1AF8B4B604B8B6BD722C47DE7CA150624FEE125BCFE5185B9CD37F592C'
$url64          = 'https://github.com/dokan-dev/dokany/releases/download/v1.0.3/Dokan_x64.msi' 
$checksum64     = '6C6FE9F8384505CFF4268388E7C0BF92E38946E57A912E46312B80D6E24B4B47'
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

Install-ChocolateyPackage @packageArgs  
  
