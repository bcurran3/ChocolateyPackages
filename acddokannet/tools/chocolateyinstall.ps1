$packageName   = 'acddokannet'
$installerType = 'msi'
$toolsDir      = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
$url           = 'https://github.com/Rambalac/ACDDokanNet/releases/download/v1.7.3/ACDDokanNetInstaller.msi' 
$checksum      = 'E8EE39CA057022EDB3639F39E5CE7A5B4BA7D168095D990848C297D010344DAC'
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
  
