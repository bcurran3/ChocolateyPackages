$packageName= 'acddokannet'
$installerType = 'msi'
$toolsDir   = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
$url        = 'https://github.com/Rambalac/ACDDokanNet/releases/download/v1.6.4/ACDDokanNetInstaller.msi' 
$checksum   = '25EFB1050A398C6CE81D634974BF1AAEBA57D43BAFCA86C99F7FB75811B69E0F'
$silentArgs = '/quiet /qn /norestart'
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
  
