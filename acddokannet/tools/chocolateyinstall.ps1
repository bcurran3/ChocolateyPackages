$packageName   = 'acddokannet'
$installerType = 'msi'
$toolsDir      = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
$url           = 'https://github.com/Rambalac/ACDDokanNet/releases/download/v1.6.5/ACDDokanNetInstaller.msi' 
$checksum      = '08B4F549A14FA6F5851B589382AD003F3480AF8820035FE860A05E839F8D5064'
$silentArgs    = '/quiet /qn /norestart'
$validExitCodes= @(0, 3010, 1641)

$packageArgs = @{
  packageName   = $packageName
  fileType      = $installerType
  url           = $url
  validExitCodes= $validExitCodes
  silentArgs    = $silentArgs
  softwareName  = 'ACDDokanNet*'
  checksum      = $checksum
  checksumType  = 'sha256' 
}

Install-ChocolateyPackage @packageArgs  
  
