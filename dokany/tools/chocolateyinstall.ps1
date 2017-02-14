$packageName    = 'dokany'
$installerType  = 'msi'
$toolsDir       = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
$url            = 'https://github.com/dokan-dev/dokany/releases/download/v1.0.2/Dokan_x86.msi' 
$checksum       = '0B374923D138C7B24C01289DFD786A8B477913A32C97D18E6CF563FB083E7D5B'
$url64          = 'https://github.com/dokan-dev/dokany/releases/download/v1.0.2/Dokan_x64.msi' 
$checksum64     = '1D777D35498198FCF2C008A237387F38130018C6B1D1B6B3810F3587D88BF1BA'
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
  
