$packageName    = 'dokany'
$installerType  = 'msi'
$toolsDir       = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
$url            = 'https://github.com/dokan-dev/dokany/releases/download/v1.0.5/Dokan_x86-1.0.5.1000.msi' 
$checksum       = 'E3D9309E9D3F94A1C2338A2902C74B4AA738C708A3C45973776BC5EAC024815B'
$url64          = 'https://github.com/dokan-dev/dokany/releases/download/v1.0.5/Dokan_x64-1.0.5.1000.msi' 
$checksum64     = '20FB30D3526CD1E4683E1E354C5E91CAAE09F3D11747A953B378F12E0D34E2F0'
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
  
